<script setup>
import SigninForm from "../components/SigninForm.vue";
import { ref, onBeforeMount, onUpdated } from "vue";

// get user
let allUser = ref([]);
const getAllUser = async () => {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/users`, {
    method: "GET",
    headers: { Authorization: localStorage.getItem("token") },
  });
  if (res.status === 200) {
    allUser.value = await res.json();
    allUser.value.sort((a, b) => a.name.localeCompare(b.name, "eng", "th"));
  }
};
onBeforeMount(async () => {
  await getAllUser();
});

// POST user
let loginWeb = async (email, password) => {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/login`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      email: email,
      password: password,
    }),
  });
  if (res.status == 200) {
    let token = await res.json();
    warningStatus.value = "correct";
    localStorage.setItem("token", "Bearer " + token.accessToken);
    let x = localStorage.getItem("token");
    console.log(x);
  } else if (res.status === 404) {
    msg.value = "A user with the specified email dose not exists";
    warningStatus.value = "warning";
  } else if (res.status == 401) {
    msg.value = "Password Incorrect";
    warningStatus.value = "warning";
  }
};

let warningStatus = ref();
let msg = ref();
</script>

<template>
  <SigninForm @login="loginWeb" :status="warningStatus" :message="msg" />
</template>

<style></style>
