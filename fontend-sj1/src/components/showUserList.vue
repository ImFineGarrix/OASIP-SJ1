<script setup>
import { ref, computed } from "vue";
const emits = defineEmits(["insert", "detail"]);
const props = defineProps({
  users: {
    type: Array,
  },
});

let showDetail = ref(false);
const openDetails = (users) => {
  showDetail.value = true;
  emits("detail", users, showDetail);
};

let showAddUser = ref(false);
const openAddUser = () => {
  showAddUser.value = true;
  emits("insert", showAddUser);
};
</script>

<template>
  <div class="font-poppin">
    <div class="pt-16 px-32">
      <div class="w-full grid grid-cols-2">
        <div>
          <h1 class="text-[64px] font-bold text-gray-900 uppercase">all user</h1>
        </div>
        <div>
          <button
            @click="openAddUser()"
            class="mt-10 ml-[75%] px-6 py-3 bg-blue-700 hover:bg-blue-500 rounded"
          >
            <p class="text-sm font-medium leading-none text-white">Add User +</p>
          </button>
        </div>
      </div>
    </div>
    <div class="overflow-auto max-h-[40rem] scroll" v-if="users != 0">
      <table class="w-10/12 mx-auto">
        <thead class="border-b border-gray-300">
          <tr class="text-base font-semibold text-gray-500 text-left">
            <th scope="col" class="px-6 py-4">Name & Role</th>
            <th scope="col" class="px-6 py-4">Email</th>
            <th scope="col" class="px-6 py-4">More</th>
          </tr>
        </thead>
        <tbody>
          <tr
            class="border-b border-gray-300 break-all"
            v-for="(users, index) in users"
            :key="index"
          >
            <td class="px-6 py-5 text-sm font-medium text-gray-900 flex">
              <div
                v-show="users.role == 'admin'"
                class="w-10 h-10 bg-rose-500 rounded flex items-center justify-center text-white"
              >
                AD
              </div>
              <div
                v-show="users.role == 'student'"
                class="w-10 h-10 bg-blue-500 rounded flex items-center justify-center text-white"
              >
                ST
              </div>
              <div
                v-show="users.role == 'lecturer'"
                class="w-10 h-10 bg-emerald-500 rounded flex items-center justify-center text-white"
              >
                LE
              </div>
              <div class="pl-5 w-7/12">
                <p class="text-lg font-semibold leading-none text-gray-900 pb-2">
                  {{ users.name }}
                </p>
                <p class="text-sm leading-3 text-gray-500 uppercase">{{ users.role }}</p>
              </div>
            </td>
            <td class="px-6 py-5 text-sm font-medium text-gray-900">
              <div class="flex">
                <svg
                  class="fill-stroke"
                  width="18"
                  height="18"
                  viewBox="0 0 24 24"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M15 10L11 14L17 20L21 4L3 11L7 13L9 19L12 15"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
                <div class="pl-5 w-2/3">
                  <p>{{ users.email }}</p>
                </div>
              </div>
            </td>
            <td>
              <button
                @click="openDetails(users)"
                class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-5 py-2.5 hover:text-gray-900"
              >
                detail
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div v-if="users == 0">
      <div class="py-24 mx-auto w-8/12">
        <div class="h-max bg-white rounded mx-auto">
          <img
            src="../../public/images/illustration/noevent.png"
            class="w-4/12 mx-auto"
          />
          <h1 class="text-center font-semibold text-lg text-gray-400 py-5">No Users</h1>
        </div>
      </div>
    </div>
  </div>
</template>

<style></style>
