import java.util.*;

class Warehouse {
    private Map<String, Product> map =  new HashMap<String, Product>();

    private class Product { int quantity = 0; }

    private Product get(String item) {
        Product p = map.get(item);
        if (p != null) return p;
        p = new Product();
        map.put(item, p);
        return p;
    }

    public void supply(String item, int quantity) {
        Product p = get(item);
        p.quantity += quantity;
    }

    // Errado se faltar algum produto...
    public void consume(Set<String> items) {
        for (String s : items)
            get(s).quantity--;
    }

}
