package ex3;

import java.time.LocalDate;
import java.time.chrono.ChronoLocalDateTime;
import java.util.Collections;
import java.util.Comparator;
import java.util.Map;
import java.util.stream.Collectors;

public class SistemaVideos implements Comparable<SistemaVideos>{
    private Map<String, VideoYoutube> videos;

    public SistemaVideos() {
        this.videos = Collections.emptyMap();
    }

    public SistemaVideos(Map<String, VideoYoutube> vids) {
        this.videos = vids.values().stream().collect(Collectors.toMap(VideoYoutube::getNomeVideo, VideoYoutube::clone));
    }

    public SistemaVideos(SistemaVideos sis) {
        this(sis.videos);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("Videos: ");
        this.videos.values().forEach(a->sb.append(a.toString()));

        return sb.toString();
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        SistemaVideos s = (SistemaVideos) o;
        return this.videos.equals(s.videos);
    }

    public SistemaVideos clone() {
        return new SistemaVideos(this);
    }

    public int compareTo(SistemaVideos sis) {
        return this.videos.size() - sis.videos.size();
    }

    public void addVideo(VideoYoutube v) {
        this.videos.put(v.getNomeVideo(), v.clone());
    }

    public VideoYoutube getVideo(String nome) {
        return this.videos.getOrDefault(nome,null).clone();
    }

    public void removeVideo(String nome) {
        this.videos.remove(nome);
    }

    public void addLike(String nome) {
        this.videos.forEach( (k, v) -> {
            if (k.equals(nome)) {
                v.setLikes(v.getLikes()+1);
            }
        });
    }

    public String topLikes() {
        if (this.videos.isEmpty()) return null;
        return this.videos.values().stream().min((a, b) -> b.getLikes() - a.getLikes()).get().getNomeVideo();
    }

    // Deve haver uma mandeira melhor de fazer isto
    public String topLike(LocalDate dInicial, LocalDate dFinal) {
        if (this.videos.isEmpty()) return null;
        VideoYoutube v =  this.videos.values().stream().filter(a->
                a.getData().isAfter(ChronoLocalDateTime.from(dInicial))
                && a.getData().isBefore(ChronoLocalDateTime.from(dFinal)))
                .min((a, b) -> b.getLikes() - a.getLikes()).orElse(null);
        return (v == null) ? null : v.getNomeVideo();
    }

    // Deve haver uma mandeira melhor de fazer isto
    public VideoYoutube videoMaisLongo() {
        if (this.videos.isEmpty()) return null;
        Comparator<VideoYoutube> comp = Comparator.comparing(a->-a.getMinutos());
        Comparator<VideoYoutube> comparadorFinal = comp.thenComparing(Comparator.comparing(a->-a.getSegundos()));
        VideoYoutube v = this.videos.values().stream().min(comp).orElse(null);
        return (v == null) ? null : v.clone();
    }

    // getters e setters
    public void setVideos(Map<String, VideoYoutube> vids) {
        this.videos = vids.values().stream().collect(Collectors.toMap(VideoYoutube::getNomeVideo, VideoYoutube::clone));
    }

    public Map<String, VideoYoutube> getVideos() {
        return this.videos.values().stream().collect(Collectors.toMap(VideoYoutube::getNomeVideo, VideoYoutube::clone));
    }

}
