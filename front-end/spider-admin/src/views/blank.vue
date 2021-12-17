<template>
    
</template>
<script setup>
/* location.go(-1)  */
import { useRouter, useRoute } from "vue-router";

const router = useRouter();
const route = useRoute();
router.push({path: "/search", query: { msg: route.query.msg, key: route.query.key, userId:route.query.userId}})

</script>
