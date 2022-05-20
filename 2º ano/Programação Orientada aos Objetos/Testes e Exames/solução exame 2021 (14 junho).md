# Exame 20-21

Proposta de Resolucao

Avaliação: Exame de Programação Orientada aos Objectos (A) MiEI e LCC - DI/UMinho 14/06/2021

by [Alef Keuffer](https://github.com/Alef-Keuffer)

## 1 ultima

```java
public Equipa getEquipa(String idClube, String idEquipa)
throws ClubeNaoExisteException, EquipaNaoExisteException{
    Equipa res = null;
    Clube c = this.clubes.get(idClube);
    if (c!= null){
        Map<String,Equipa > equipas = c.getEquipas();
        if (equipas.containsKey(idEquipa)){
            res = equipas.get(idEquipa).clone();
        }
    }else{
        throw new ClubeNaoExisteException()
    }
    if (res == null){
        throw new EquipaNaoExisteException();
    }
    return res;
}
```

## 2. penultima

```java
public List<Equipa> getEquipas(String idClube, String escalao) throws ClubeNaoExisteException {
    List<Equipa> res = new ArrayList<>();
    if (this.clubes.containsKey(idClube)){
        for(Equipa e: this.clubes.get(idClube).getEquipas().values()){
            if(e.getEscalao().equals(escalao)){
                res.add(e.clone());
            }
        }
    }else{
        throw new ClubeNaoExisteException();
    }
    return res;
}
```

## 3

### 3 __Resposta__


1. `getEEstatus1(lemp)` causes a compilation error:

    ```sh
    java: cannot find symbol
      symbol:   method epocaEspecial()
      location: variable a of type Empregado
    ```

    to fix it write

    ```java
        List<Boolean> getEEstatus1(List<Empregado> l) {
            return l.stream().filter(e -> e instanceof Aluno).map(a -> ((Aluno) a).epocaEspecial())
                    .collect(Collectors.toList());
        }
    ```
2. `getEEstatus2(lal)` produces `[true,false]`
3. `getEEstatus3(lemp)` causes an execution error (`java.lang.ClassCastException`) because it tries to cast `Funcionario` to `Aluno`.

Therefore at

- 3a): `getEEstatus1(lemp);`
- 3b): `getEEstatus2(lal)`
- 3c): `getEEstatus3(lemp)`
- 3d): None

## 4

### 4 __Resposta__

b) (segunda).

> O metodo esta corretamente implementado, mas as turmas sem alunos sao consideradas com media 0.0.

### 4 a)

> O metodo esta corretamente implementado, mas na ultima linha usa-se um `orElse` desnecessario; bastava terminar a linha com `findFirst`.

Nao é desnecessário, se não fizessemos 'orElse' a função iria ter de retornar `Optional<String>`.

### 4 c)

> O metodo esta corretamente implementado, porem numa estrategia de composicao seria necessario acrescentar invocacoes apropriadas ao metodo clone.

Incorreto, nao modificamos nenhum dos objetos para ordenar e nao deixamos escapar nenhuma referencia dos objetos que estamos a manipular. A String é imutável e não é necessário fazer clone dela.

### 4 d)

> O metodo esta incorretamente implementado, pois nao se podem construir streams sobre o resultado do metodo entrySet.

False because `entrySet()` returns `Set` which is a `Collection` so it has `stream()` method.

### 4 e) (unjustified)

> O metodo esta incorretamente implementado pois, como se pretende ter uma ordenacao com dois criterios, deve-se usar dois Comparators.

We can use two comparators to sort the elements using two criteria:

```java
list.sort(Comparator.comparing(studentAverage).thenComparing(numberOfStudents))
```

### 4 f)

> O metodo esta incorretamente implementado visto que e necessario usar o metodo compareTo para produzir o resultado do Comparator.

False, `Comparator<T>` is an interface that requires the implementation of only one (note: it's a functiona interface) method (`int compare(T o1, T o2)`), nothing in its contract requires us to use `compareTo`. Note that `compareTo` requires implementation of `Comparable` and if we want an order diffrent from the one implicitly established by `compareTo` we use a `Comparator`.

## 5

### 5 __Resposta__

c) (terceira)

> Os metodos nao estao estao correctamente implementados, nao sendo consistentes no
tratamento do encapsulamento.

`getAtletas()` shares references to all `Pessoa` inside `Equipa` to the oustide. On the other hand, `setAtletas(Set<Pessoa> s)` clones each `Pessoa` that in `s` so that internally `Equipa` does not have references to `Pessoa` controlled by the outside world. I consider this inconsistent.

## 6

SpotifyPOO < Podcast < Episodio

```java
class Podcast {
    /* Um podcast possui um identificador (um nome) e tem associada uma lista de
       episodios que foram disponibilizados. */
    String name;
    List<Episodio> episodes;
}

class SpotifyPOO {

    /* SpotifyPOO guarda informacao relativa aos podcasts existentes e dos episodios destes */
    Map<String,Podcast> podcasts; // maps podcast name (unique identifier) to podcast

    /* informacao relativa aos utilizadores do sistema. Para cada utilizador guarda-se o seu identificador (que neste sistema e a String do seu email), o seu nome e a informacao dos podcasts que tem subscritos */
    private static class Utilizador {
        /* Para cada utilizador guarda-se o seu identificador (que neste sistema e a String do seu email), o
            seu nome e a informacao dos podcasts que tem subscritos. */
        String email; //not final (think about other services that allow you to change email), but must be unique.
        String username;
        Set<Podcast> podcasts; // names of the podcasts its subscribed to
    }
    Map<String,Utilizador> users; // maps each user email to user

    public List<Episodio> getEpisodios(String nomePodcast) {
        Podcast p = podcasts.get(nomePodcast);
        if (p==null)
            return new ArrayList<Episodio>();
        return p.episodes.stream().map(Episodio::clone).toList();
    }
}
```

## 7

Sem resposta por enquanto.

```puml
@startuml
class Podcast {
    /* Um podcast possui um identificador (um nome) e tem associada uma lista de
       episodios que foram disponibilizados. */
    String name;
    List<Episodio> episodes;
}

class SpotifyPOO {

    /* SpotifyPOO guarda informacao relativa aos podcasts existentes e dos episodios destes */
    Map<String,Podcast> podcasts; // maps podcast name (unique identifier) to podcast

    /* informacao relativa aos utilizadores do sistema. Para cada utilizador guarda-se o seu identificador (que neste sistema e a String do seu email), o seu nome e a informacao dos podcasts que tem subscritos */
    private static class Utilizador {
        /* Para cada utilizador guarda-se o seu identificador (que neste sistema e a String do seu email), o
            seu nome e a informacao dos podcasts que tem subscritos. */
        String email; //not final (think about other services that allow you to change email), but must be unique.
        String username;
        Set<String> podcasts; // names of the podcasts its subscribed to
    }
    Map<String,User> users; // maps each user email to user

    public List<Episodio> getEpisodios(String nomePodcast) {
        Podcast p = podcasts.get(nomePodcast);
        if (p==null)
            return new ArrayList<Episodio>();
        return p.episodes.stream().map(Episodio::clone).toList();
    }
}
@end
```

## 8

`Function<? super T,? extends Stream<? extends R>>`

Solution 1:

```java
public void removeIvo(String nomeP) throws PodcastNotRegistered, PodcastHasSubscription {
    Podcast p = podcasts.get(nomeP);
    if (p == null)
        throw new PodcastNotRegistered();
    Optional<String> userSubscribed =
            users.entrySet()
                 .stream()
                 .filter(e -> e.getValue().getPodcasts().stream().anyMatch(nomeP::equals))
                 .map(Map.Entry::getKey)
                 .findAny();
    if (userSubscribed.isPresent())
        throw new PodcastHasSubscription(userSubscribed.get());
    podcasts.remove(nomeP);
}
```

Solution 2:

```java
public void remove(String nomeP) throws PodcastNotRegistered, PodcastHasSubscription {
    Podcast p = podcasts.get(nomeP);
    if (p == null)
        throw new PodcastNotRegistered();
    if (users.values()
             .stream()
             .map(Utilizador::getPodcasts)
             .flatMap(Collection::stream)
             .anyMatch(n -> n.equals(nomeP))
    )
        throw new PodcastHasSubscription();
    podcasts.remove(nomeP);
}
```

note that we would have inside `SpotifyPOO`

```java
static class PodcastHasSubscription extends Exception {
    public PodcastHasSubscription(String s) {}
    public PodcastHasSubscription() {}
}

static class PodcastNotRegistered extends Exception {}
```

## 9

```java
public Episodio getEpisodioMaisLongo(String u) {
        // throws if user does not exists and if user is not subscribed to any podcast
        return users
                .get(u)
                .getPodcasts()
                .stream()
                .flatMap(pName -> podcasts.get(pName).episodes.stream())
                .max(Comparator.comparingDouble(Episodio::getDuracao))
                .get();
    }
```

## 10

Solution 1:

```java
public Map<Integer, List<Episodio>> episodiosPorClassf() {
    Map<Integer, List<Episodio>> map = new HashMap<>();
    podcasts.values()
            .stream()
            .flatMap(p -> p.getEpisodios().stream())
            .forEach(e -> map.getOrDefault(e.getClassificacao(), new ArrayList<>()).add(e));
    return map;
}
```

Solution 2:

```java
public Map<Integer, List<Episodio>> episodiosPorClassf() {
    Map<Integer, List<Episodio>> map = new HashMap<>();
    List<Episodio> episodes = new ArrayList<>();
    for (Podcast p: podcasts.values())
        episodes.addAll(p.getEpisodios());
    for (Episodio e : episodes) {
        int i = e.getClassificacao();
        if (!map.containsKey(i))
            map.put(i,new ArrayList<>());
        map.get(i).add(e);
    }
    return map;
}
```

## 11

`private List<String> conteudo;` corresponde ao texto que e dito quando se reproduz o episodio.


```java
public class Episodio implements Playable {
    //...
    public void play() {conteudo.stream().forEach(System.media::print);}
}
```

Posso concatenar tudo e fazer print de uma vez so.

## 12

Assumes `Episodio implements Playable`.

```java
class EpisodioVideo extends Episodio {
    List<Byte> video;

    public EpisodioVideo(..., List<Byte> video) {
        super(...)//
        this.video = video;
    }

    @Override
    public void play() {
        super.play(); // deve ser depois. mas nao podemos usar super entao.
        video.forEach(System.media::print);
    }
}
```

ou

```java
class EpisodioVideo extends Episodio {
    List<Byte> video;

    public EpisodioVideo(String nome, double duracao, int classificacao, List<String> conteudo, int numeroVezesTocada,
                         LocalDateTime ultimaVez, List<Byte> video)
    {
        super(nome, duracao, classificacao, conteudo, numeroVezesTocada, ultimaVez);
        this.video = video;
    }

    @Override
    public void play() {
        super.play();
        video.forEach(System.media::print);
    }
```

## 13

Considere que se pretende criar agora
a no¸c˜ao de UtilizadorPremium, que ´e um utilizador que, enquanto reproduz um epis´odio,
possui a capacidade de colocar os outros epis´odos que pretende reproduzir numa lista de
espera


```java
public void playEpisodio(String idPodCast, String nomeEpisodio) throws AlreadyPlayingException {
    Episodio e = podcasts
        .stream()
        .filter(idPodCast::equals)
        .map(Episodio::getEpisodios)
        .flatMap(Collection::stream)
        .filter(e -> nomeEpisodio.equals(e.getNome()))
        .findAny()
        .get(); //throws
}
```

## 14

```java
public void gravaInfoEpisodiosParaTocarMaisTarde(String fich) throws IOException {
    PrintWriter writer = new PrintWriter(fich);
    users.values()
         .stream()
         .filter(u -> u instanceof UtilizadorPremium)
         .map(u -> (UtilizadorPremium) u)
         .forEach(u -> {
             writer.write(u.getNome() + "\n");
             u.waitQueue.forEach(e -> writer.write(e.getNome() + " - " + e.getDuracao() + "\n"));
         });
    writer.flush();
    writer.close();
}
```