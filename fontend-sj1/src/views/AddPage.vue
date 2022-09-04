<script setup>
import AddEventForm from "../components/AddEventForm.vue";
import { ref, onBeforeMount } from "vue";

// get EventList
let list = ref([]);
const getList = async () => {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/events`, {
    method: "GET",
    headers: { Authorization: localStorage.getItem("token") },
  });
  if (res.status === 200) {
    list.value = await res.json();
    list.value.sort((a, b) => b.eventStartTime.localeCompare(a.eventStartTime));
  } else console.log("Not Found");
};

// get CategoryList
let eventCategoryList = ref([]);
const getListCategory = async () => {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/categories`, {
    method: "GET",
    headers: { Authorization: localStorage.getItem("token") },
  });
  res.status === 200
    ? (eventCategoryList.value = await res.json())
    : console.log("not found");
};
onBeforeMount(async () => {
  await getList();
  await getListCategory();
});

// POST Method
let addEvent = async (event, date) => {
  const res = await fetch(`${import.meta.env.VITE_BASE_URL}/events`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: localStorage.getItem("token"),
    },
    body: JSON.stringify({
      bookingName: event.bookingName.value,
      bookingEmail: event.bookingEmail,
      eventCategoryId: eventCategoryList.value[event.eventCategory].id,
      eventStartTime: date,
      eventDuration: eventCategoryList.value[event.eventCategory].eventDuration,
      eventNotes: event.eventNotes.value,
    }),
  });
  if (res.status == 201) {
    console.log("Add event complete!");
  } else {
    alert("Error to add event!");
  }
};
</script>

<template>
  <div class="mx-auto">
    <AddEventForm
      @add="addEvent"
      :listCategory="eventCategoryList"
      :listEvent="list"
    ></AddEventForm>
  </div>
</template>

<style></style>
