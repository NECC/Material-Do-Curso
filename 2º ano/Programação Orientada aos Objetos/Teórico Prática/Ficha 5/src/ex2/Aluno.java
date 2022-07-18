package ex2;
/*********************************************************************************/
/** DISCLAIMER: Este código foi criado e alterado durante as aulas práticas      */
/** de POO. Representa uma solução em construção, com base na matéria leccionada */ 
/** até ao momento da sua elaboração, e resulta da discussão e experimentação    */
/** durante as aulas. Como tal, não deverá ser visto como uma solução canónica,  */
/** ou mesmo acabada. É disponibilizado para auxiliar o processo de estudo.      */
/** Os alunos são encorajados a testar adequadamente o código fornecido e a      */
/** procurar soluções alternativas, à medida que forem adquirindo mais           */
/** conhecimentos de POO.                                                        */
/*********************************************************************************/

/**
 * Classe ex2.Aluno.
 * Classe que modela de forma muito simples a 
 * informação e comportamento relevante de um aluno.
 * 
 * @author MaterialPOO
 * @version 20200216
 * @version 20210406
 */

public class Aluno implements Comparable<Aluno>{
 
    private String numero;
    private int nota;
    private String nome;
    private String curso;

    /**
     * Constructores para a classe ex2.Aluno
     */
    public Aluno() {
      this.numero = "";
      this.nota = 0;
      this.nome = "";  
      this.curso = "";
    }
    
    public Aluno(String numero, int nota, String nome, String curso) {
        this.numero = numero;
        this.nota = nota;
        this.nome = nome;
        this.curso = curso;
    }
    
    public Aluno(Aluno umAluno) {
        this.numero = umAluno.getNumero();
        this.nota = umAluno.getNota();
        this.nome = umAluno.getNome();
        this.curso = umAluno.getCurso();
    }     
    
    /**
     * Método que devolve o número de um aluno.
     * 
     * @return String com o número do aluno
     */
    public String getNumero() {
      return this.numero;
    }
    
    /**
     * Método que devolve a nota de um aluno.
     * 
     * @return int com o número do aluno
     */
    public int getNota() {
      return this.nota;
    }
    
    /**
     * Método que devolve o nome de um aluno.
     * 
     * @return String com o nome do aluno
     */
    public String getNome() {
      return this.nome;
    }
    
    /**
     * Método que devolve o curso de um aluno.
     * 
     * @return String com o número do aluno
     */
    public String getCurso() {
      return this.curso;
    }
    
    
   public void setNota(int novaNota) {
     this.nota = novaNota;
   }
    
   public void setNumero(String numero) {
     this.numero = numero;
   }
   
   public void setNome(String nome) {
     this.nome = nome;
   }
   
   public void setCurso(String curso) {
     this.curso = curso;
   }
   
    /**
     * Implementação do método toString
     * comum na maioria das classes Java.
     * 
     * @return     uma string com a informação textual do objecto aluno
     */
    public String toString() {
      StringBuffer sb= new StringBuffer();
        
      sb.append("Numero: ");
      sb.append(this.numero+"\n");
      sb.append("Nome: ");
      sb.append(this.nome+"\n");
      sb.append("Curso: ");
      sb.append(this.curso+"\n");
      sb.append("Nota: ");
      sb.append(this.nota+"\n");
        
      return sb.toString();
        
        //embora obrigue a maior esforço de escrita, esta implementação
        //é mais eficiente que a normal
        //return("Numero:" + this.numero + "Nome:"+ this.nome + "Nota:" + this.nota);
        
    }
        
    /**
    * Implementação do método de igualdade entre dois ex2.Aluno
    * Redefinição do método equals de Object.
    * 
    * @param  umAluno   aluno que é comparado com o receptor
    * @return      booleano true ou false
    */
    public boolean equals(Object o) {
      if (this == o)
        return true;
      
      if((o == null) || (this.getClass() != o.getClass()))
        return false;
      
      Aluno umAluno = (Aluno) o;
      return(this.nome.equals(umAluno.getNome()) && this.nota == umAluno.getNota() 
            && this.numero.equals(umAluno.getNumero()) 
            && this.curso.equals(umAluno.getCurso()));
    }
  
    /**
    * Implementação do método de clonagem de um ex2.Aluno
    * 
    * @return  objecto do tipo ex2.Aluno
    */
         
   public Aluno clone() {
     return new Aluno(this);    
   }
     
   
   /**
    * Implementação de hashCode.
    * Exemplo para ser modificado, neste caso recorre ao hashCode
    * das String.
   */

   public int hashCode() {
     return this.nome.hashCode() + this.numero.hashCode() + 
            this.curso.hashCode() + this.nota*7;    
   }
   
   /**
    * Implementação da ordem natural.
    * Neste caso a ordem natural é alfabeticamente crescente.
    * 
    */
    
    public int compareTo(Aluno outroAluno) {
      return this.nome.compareTo(outroAluno.getNome());  
    } 
        
   
}
