package ex2;

import java.util.*;
import java.util.stream.Collectors;

public class TurmaAlunos {
    private Map<String, Aluno> alunos;
    private String nomeTurma;
    private String uc;

    public TurmaAlunos() {
        this.alunos = new HashMap<>();
        this.nomeTurma = "";
        this.uc = "";
    }

    public TurmaAlunos(Map<String, Aluno> al, String nome, String UC) {
        this.alunos = al.values().stream().collect(Collectors.toMap(Aluno::getNumero, Aluno::clone));
        this.nomeTurma = nome;
        this.uc = UC;
    }

    public TurmaAlunos(TurmaAlunos t) {
        this(t.alunos,t.nomeTurma,t.uc);
    }

    public TurmaAlunos clone() {
        return new TurmaAlunos(this);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        TurmaAlunos t = (TurmaAlunos) o;
        return  this.nomeTurma.equals((t.nomeTurma)) &&
                this.uc.equals(t.uc) &&
                this.alunos.equals(t.alunos);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("Turma: ");

        sb.append(this.nomeTurma);
        sb.append("\nUC: "); sb.append(this.uc);
        if (!this.alunos.isEmpty()) {
            sb.append("\nAlunos: \n\n");
            this.alunos.values().forEach(a->{
                sb.append(a.toString());
                sb.append("\n");
            });
        }

        return sb.toString();
    }

    public int compareTo(Object o) {
        if (o.getClass() != this.getClass()) return 1;

        TurmaAlunos t = (TurmaAlunos) o;
        if (!this.nomeTurma.equals(t.nomeTurma)) {
            return this.nomeTurma.compareTo(t.nomeTurma);
        }
        if (!this.uc.equals(t.uc)) {
            return this.uc.compareTo(t.uc);
        }
        if (!this.alunos.equals(t.alunos)) {
            return this.alunos.size() - t.alunos.size();
        }
        return 0;
    }

    public void insereAluno(Aluno a) {
        this.alunos.put(a.getNumero(), a.clone());
    }

    public Aluno getAluno(String numero) {
        return this.alunos.getOrDefault(numero, null).clone();
    }

    public void removeAluno(String numero) {
        this.alunos.remove(numero);
    }

    public Set<String> todosOsCodigos() {
        return this.alunos.keySet();
    }

    public int qtsAlunos() {
        return this.alunos.size();
    }

    public Collection<Aluno> alunosOrdemAlfabetica() {
        // CompareTo do Aluno ja organiza por nome
        return this.alunos.values().stream().sorted().collect(Collectors.toList());
    }

    public Set<Aluno> alunosOrdemDecrescenteNumero() {
        SortedSet<Aluno> s = new TreeSet<Aluno>( (a,b)-> b.getNumero().compareTo(a.getNumero()));
        this.alunos.values().forEach(a -> s.add(a.clone()));
        return s;
    }

    // setters e getters
    public void setAlunos(Map<String, Aluno> al) {
        this.alunos = al.values().stream().collect(Collectors.toMap(Aluno::getNumero, Aluno::clone));
    }
    public void setNomeTurma(String nome) {
        this.nomeTurma = nome;
    }
    public void setUc(String UC) {
        this.uc = UC;
    }
    public String getUc() {
        return this.uc;
    }
    public String getNomeTurma() {
        return this.nomeTurma;
    }
    public Map<String, Aluno> getAlunos() {
        return this.alunos.values().stream().collect(Collectors.toMap(Aluno::getNumero, Aluno::clone));
    }
}
