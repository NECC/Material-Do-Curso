package exercicios;

import java.util.ArrayList;

public class Stack {
    private ArrayList<String> valores;

    public Stack() {
        this.valores = new ArrayList<String>();
    }

    public Stack(ArrayList<String> a) {
        this.valores = new ArrayList<String>(a);
    }

    public Stack(Stack s) {
        this(s.valores);
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        Stack s = (Stack) o;
        return this.valores.equals(s.valores);
    }

    public String toString() {
        return this.valores.toString();
    }

    public Stack clone() {
        return new Stack(this);
    }

    public String top() {
        return this.valores.get(this.valores.size() - 1);
    }

    public void push(String s) {
        this.valores.add(s);
    }

    public void pop() {
        this.valores.remove(this.valores.size() - 1);
    }

    public boolean empty() {
        return this.valores.isEmpty();
    }

    public int length() {
        return this.valores.size();
    }
}
