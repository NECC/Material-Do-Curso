public class SmartBulb extends SmartDevice {
    public static final int WARM = 3;
    public static final int NEUTRAL = 2;
    public static final int COLD = 1;

    private int tone;

    public SmartBulb() {
        super();
        this.tone = NEUTRAL;
    }

    public SmartBulb(String ID) {
        super(ID);
        this.tone = NEUTRAL;
    }
    public SmartBulb(String ID, int to) {
        super(ID);
        this.tone = to;
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        SmartBulb sb = (SmartBulb) o;
        return super.equals(o) && this.tone == sb.tone;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("\nTone: "); sb.append(this.tone);

        return super.toString() + sb.toString();
    }

    public SmartBulb clone() {
        return new SmartBulb(this.getID(), this.tone);
    }

    // setters e getters
    public int getTone() {
        return this.tone;
    }
    public void setTone(int t) {
        this.tone = t;
    }
}
