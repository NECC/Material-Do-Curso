package exercicios;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class FBFeed {
    ArrayList<FBPost> posts;

    public FBFeed(ArrayList<FBPost> lista) {
        this.posts = new ArrayList<FBPost>();
        for (FBPost elem : lista) {
            this.posts.add(elem.clone());
        }
    }

    public FBFeed() {
        this(new ArrayList<FBPost>());
    }

    public FBFeed(FBFeed fbf) {
        this(fbf.posts);
    }

    public FBFeed clone() {
        return new FBFeed(this);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        FBFeed fbf = (FBFeed) o;
        if (fbf.posts.size() != this.posts.size()) return false;

        boolean same = true;
        for (int i = 0; i < this.posts.size() && same; i++) {
            same = this.posts.get(i).equals(fbf.posts.get(i));
        }

        return same;
    }

    public int nrPosts(String user) {
        return (int) this.posts.stream().filter(a->a.getUtilizador().equals(user)).count();
    }

    public List<FBPost> postsOf(String user) {
        return this.posts.stream().filter(a->a.getUtilizador().equals(user)).collect(Collectors.toList());
    }

    public List<FBPost> postsOf(String user, LocalDateTime inicio, LocalDateTime fim) {
        List<FBPost> ret = this.posts.stream().filter(a->a.getUtilizador().equals(user)).collect(Collectors.toList());
        ret.removeIf(a->a.getData().isBefore(inicio) || a.getData().isAfter(fim));
        return ret;
    }

    public FBPost getPost(int id) {
        FBPost ret = this.posts.stream().filter(a->a.getId() == id).findFirst().orElse(null);
        if (ret != null) ret = ret.clone();
        return ret;
    }

    public void comment(FBPost post, String comentario) {
        boolean enc = false;
        int i = 0;
        for (i = 0; !enc && i < this.posts.size(); i++) {
            FBPost p = this.posts.get(i);
            if (p.equals(post))
                enc = true;
        }
        if (!enc) i = this.posts.size();
        else i--;
        ArrayList<String> com = post.getComentarios();
        com.add(comentario);
        post.setComentarios(com);
        this.posts.set(i, post);
    }

    public void comment(int id, String comentario) {
        boolean enc = false;
        int i;
        for (i = 0; !enc && i < this.posts.size(); i++)
            if (id == this.posts.get(i).getId()) enc = true;
        if (enc) {
            i--;
            FBPost post = this.posts.get(i);
            ArrayList<String> com = post.getComentarios();
            com.add(comentario);
            post.setComentarios(com);
            this.posts.set(i, post);
        }
    }

    public void like(FBPost post) {
        boolean enc = false;
        int i = 0;
        for (i = 0; !enc && i < this.posts.size(); i++) {
            FBPost p = this.posts.get(i);
            if (p.equals(post))
                enc = true;
        }
        if (!enc) i = this.posts.size();
        else i--;
        int likes = post.getLikes() + 1;
        post.setLikes(likes);
        this.posts.set(i, post);
    }

    public void like(int id) {
        boolean enc = false;
        int i;
        for (i = 0; !enc && i < this.posts.size(); i++)
            if (id == this.posts.get(i).getId()) enc = true;
        if (enc) {
            i--;
            FBPost post = this.posts.get(i);
            int likes = post.getLikes() + 1;
            post.setLikes(likes);
            this.posts.set(i, post);
        }
    }

    public List<Integer> top5Comments() {
        ArrayList<FBPost> lista = new ArrayList<>(this.posts);

        lista.sort(Comparator.comparing(FBPost::getId));
        Collections.reverse(lista);

        return lista.stream().mapToInt(FBPost::getId).limit(5).boxed().collect(Collectors.toList());
    }
}