<script setup>
import Home from "../components/Home.vue";
import { ref, onBeforeMount } from "vue";
</script>

<template>
  <Home :eventList="list" :categoryList="eventCategoryList" />
</template>

<style></style>
