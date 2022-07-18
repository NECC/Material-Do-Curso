public class SmartDevice {
    private String id;
    private boolean on;

    public SmartDevice() {
        this.id = "";
        this.on = false;
    }

    public SmartDevice(String ID) {
        this.id = ID;
    }

    public SmartDevice(String ID, boolean ON) {
        this.id = ID;
        this.on = ON;
    }

    public boolean equals(Object o) {
        if (this == o) return true;

        if (o == null || this.getClass() != o.getClass()) return false;

        SmartDevice sd = (SmartDevice) o;
        return sd.on == this.on && this.id.equals(sd.id);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();

        sb.append("ID: "); sb.append(this.id);
        sb.append("\nON: "); sb.append(this.on);

        return sb.toString();
    }

    // setters e getters
    public void setID(String ID) {
        this.id = ID;
        this.on = false;
    }
    public String getID() {
        return this.id;
    }
    public void setOn(boolean estado) {
        this.on = estado;
    }
    public boolean getOn() {
        return this.on;
    }
}
