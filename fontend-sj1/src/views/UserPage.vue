<script setup>
import ShowUser from "../components/showUserList.vue";
import DetailUser from "../components/DetailUser.vue";
import AddUser from "../components/AddUserForm.vue";
import { ref, onBeforeMount } from "vue";

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
let addUser = async (user, name, password) => {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/users/register`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      name: name,
      email: user.email.value,
      password: password,
      role: user.role.value,
    }),
  });
  if (res.status == 201) {
    console.log("Add event complete!");
    getAllUser();
  } else {
    alert("Error to add event!");
  }
};

// PUT Method
const updateUser = async (user, name) => {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/users/${user.id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
      Authorization: localStorage.getItem("token"),
    },
    body: JSON.stringify({
      name: name,
      email: user.email.value,
      role: user.role.value,
    }),
  });
  if (res.status == 200) {
    const update = await res.json();
    allUser.value.map((user) => {
      if (user.id == update.id) {
        user.name.value = update.name.value;
        user.email.value = update.email.value;
        user.role.value = update.role.value;
      }
    });
    getAllUser();
  }
};

// delete Method
const deleteUser = async (id) => {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/users/${id}`, {
    method: "DELETE",
    headers: { Authorization: localStorage.getItem("token") },
  });
  if (res.status == 200) {
    allUser.value = allUser.value.filter((user) => user.id != id);
    console.log("delete successfully");
  } else console.log("error, cannot delete");
};

let statusShowDetail = ref();
let detail = ref({});
const userToDetail = (user, status) => {
  detail.value = user;
  statusShowDetail.value = status;
};

let statusShowAddUser = ref();
const openAddUser = (status) => {
  statusShowAddUser.value = status;
};
</script>

<template>
  <div>
    <ShowUser :users="allUser" @insert="openAddUser" @detail="userToDetail" />
    <AddUser :users="allUser" :statusInsert="statusShowAddUser" @add="addUser" />
    <DetailUser
      :users="allUser"
      :detailList="detail"
      :statusDetail="statusShowDetail"
      @save="updateUser"
      @delete="deleteUser"
    />
  </div>
</template>

<style></style>
