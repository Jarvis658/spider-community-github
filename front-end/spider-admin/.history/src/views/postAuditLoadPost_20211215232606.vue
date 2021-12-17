<template>
    <div><button @click="pass" class="btn btn-primary">pass</button></div>
    <div><button @click="reject" class="btn btn-primary">reject</button></div>
    <div v-html="Post.post_content"/ >
</template>

<script setup>
import { reactive, ref } from "@vue/reactivity";
import { post, setLocalToken, tip } from "@/common";
import { useRouter, useRoute } from "vue-router";

    const router =useRouter();
    const route=useRoute();

    const Dto=reactive(
        {
            audit_status:"",
            post_id:""
        }
    )

    var Post=ref([])

    post("/admin/audit/changestatus",{
        audit_status:Dto.audit_status,post_id:route.query.post_id
    }).then((res)=>{
        Post=res.data
    })

    const pass=function()
    {
        post("/admin/audit/setstatus",{
            audit_status:1,post_id:route.query.post_id
        }).then((res)=>{
            console.log("/")
        })
    }

    const reject=function()
    {
        post("/admin/audit/setstatus",
        {
            audit_status:0,post_id:route.query.post_id
        }).then((res)=>{
            console.log("!")
        })
    }
</script>

<style>

</style>