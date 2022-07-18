public class SmartSpeaker extends SmartDevice {
    public static final int MAX = 25;

    private int volume;
    private String channel;

    public SmartSpeaker() {
        super();
        this.volume = 0;
        this.channel = "";
    }

    public SmartSpeaker(String ID) {
        super(ID);
        this.volume = 0;
        this.channel = "";
    }

    public SmartSpeaker(String ID, String ch, int vol) {
        super(ID);
        this.channel = ch;
        this.volume = vol;
    }

    public SmartSpeaker clone() {
        return new SmartSpeaker(this.getID(), this.channel, this.volume);
    }

    public void volumeUp() {
        if (this.volume < MAX) this.volume+=1;
    }

    public void volumeDown() {
        if (this.volume > 0) this.volume-=1;
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || o.getClass() != this.getClass()) return false;

        SmartSpeaker ss = (SmartSpeaker) o;
        return super.equals(o) && this.volume == ss.volume && this.channel.equals(ss.channel);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("\nVolume: "); sb.append(this.volume);
        sb.append("\nCanal: "); sb.append(this.channel);

        return super.toString() + sb.toString();
    }

    // setters e getters
    public void setVolume(int vol) {
        this.volume = vol;
    }
    public int getVolume() {
        return this.volume;
    }
    public void setChannel(String ch) {
        this.channel = ch;
    }
    public String getChannel() {
        return this.channel;
    }
}
