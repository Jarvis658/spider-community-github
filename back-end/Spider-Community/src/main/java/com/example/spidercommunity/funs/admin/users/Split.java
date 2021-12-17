package com.example.spidercommunity.funs.admin.users;


import java.util.ArrayList;

public class Split {
    public static ArrayList split(String str)
    {

        String [] arr = str.split("\\s+");
        ArrayList list =new ArrayList();
        for(String ss : arr){
            list.add(ss)   ;
        }
        return list;
    }
}
