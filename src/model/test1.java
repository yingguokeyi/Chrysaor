package model;

public class test1 {
        public static void main(String[] args) {
            String a= "[\"http://localhost:8080/cronus/goods/goodsAdd\",\"http://localhost:8080/cronus/goods/goodsAdd\"]";
            System.out.println(a.substring(2,a.length()-2));
            System.out.println(a.substring(2,a.length()-2).replaceAll("\"",""));
        }
}
