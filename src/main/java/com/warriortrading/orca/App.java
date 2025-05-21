package com.warriortrading.orca;

import com.nirvana.lib.a.Customer;

public class App {
    public static void main(String[] args) {
        Customer customer = new Customer();
        customer.setName("John Doe");
        customer.setId(1001L);
        System.out.println(customer);
    }
} 