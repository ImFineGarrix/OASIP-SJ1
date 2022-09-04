<script setup>
import { ref, computed } from "vue";
const emits = defineEmits(["login"]);
const props = defineProps({
  status: {
    type: String,
    default: "",
  },
  message: {
    type: String,
    default: "",
  },
});
const matchingPassword = computed(() => {
  return {
    email: ref(""),
    password: ref(""),
    status: ref(props.status),
    message: ref(props.message),
  };
});

const login = (match) => {
  let email = match.email.value.trim();
  let password = match.password.value;
  if (email == "") {
    matchingPassword.value.message.value = "Please fill your email";
    matchingPassword.value.status.value = "warning";
  } else if (
    !email.match(/^([a-zA-Z0-9._-])+@\w+([a-zA-Z0-9._-])*(\.[a-zA-Z0-9_-]{2,10})+$/)
  ) {
    matchingPassword.value.message.value = "Please provide a valid email address";
    matchingPassword.value.status.value = "warning";
  } else if (password == "") {
    matchingPassword.value.message.value = "Please fill your password";
    matchingPassword.value.status.value = "warning";
  } else if (password.length < 8 || password.length > 14) {
    matchingPassword.value.message.value = "Please password length 8 between 14";
    matchingPassword.value.status.value = "warning";
  } else {
    emits("login", email, password);
  }
};

const closeWarning = () => {
  matchingPassword.value.status.value = "";
};

let typePassword = ref("password");
function changeTypePassword() {
  if (typePassword.value == "password") {
    typePassword.value = "type";
  } else {
    typePassword.value = "password";
  }
}
</script>

<template>
  <div class="font-poppin">
    <div class="h-screen grid grid-cols-2">
      <div
        class="relative overflow-hidden"
        style="background-image: url('/public/images/pic/singin.jpeg')"
      ></div>

      <div class="w-8/12 h-screen flex justify-center py-10 items-center bg-white">
        <div class="space-y-2">
          <div>
            <h1 class="text-gray-800 font-bold text-2xl leading-none">OASIP Login!</h1>
          </div>

          <div class="flex space-x-2">
            <input
              type="text"
              placeholder="Email"
              v-model="matchingPassword.email.value"
              class="w-full pl-2 py-2 border-b border-gray-400"
            />
          </div>
          <div class="flex space-x-2">
            <input
              :type="typePassword"
              placeholder="Password"
              v-model="matchingPassword.password.value"
              class="w-full pl-2 py-2 border-b border-gray-400"
              minlength="8"
            />
            <svg
              @click="changeTypePassword()"
              v-if="typePassword == 'password'"
              class="text-gray-800 mt-3 cursor-pointer"
              width="24"
              height="16"
              fill="none"
              viewBox="0 0 22 16"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M20.257 6.962C20.731 7.582 20.731 8.419 20.257 9.038C18.764 10.987 15.182 15 11 15C6.81801 15 3.23601 10.987 1.74301 9.038C1.51239 8.74113 1.38721 8.37592 1.38721 8C1.38721 7.62408 1.51239 7.25887 1.74301 6.962C3.23601 5.013 6.81801 1 11 1C15.182 1 18.764 5.013 20.257 6.962V6.962Z"
                stroke="currentColor"
                stroke-width="0.5"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                d="M11 11C12.6569 11 14 9.65685 14 8C14 6.34315 12.6569 5 11 5C9.34315 5 8 6.34315 8 8C8 9.65685 9.34315 11 11 11Z"
                stroke="currentColor"
                stroke-width="0.5"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
            <svg
              @click="changeTypePassword()"
              v-else
              class="text-gray-800 mt-3 cursor-pointer"
              width="24"
              height="16"
              viewBox="0 0 22 18"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M5.87313 14.129C4.02813 12.819 2.56813 11.115 1.74313 10.039C1.51244 9.74198 1.38721 9.37659 1.38721 9.0005C1.38721 8.62441 1.51244 8.25902 1.74313 7.962C3.23613 6.013 6.81813 2 11.0001 2C12.8761 2 14.6301 2.807 16.1301 3.874"
                stroke="currentColor"
                stroke-width="0.5"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                d="M13.13 6.887C12.8523 6.60467 12.5214 6.38011 12.1565 6.22629C11.7916 6.07246 11.3998 5.99241 11.0038 5.99075C10.6078 5.98909 10.2154 6.06586 9.84915 6.21662C9.48295 6.36738 9.15022 6.58916 8.87016 6.86915C8.5901 7.14915 8.36824 7.48183 8.21739 7.84799C8.06654 8.21416 7.98969 8.60657 7.99125 9.00259C7.99282 9.3986 8.07278 9.79039 8.22652 10.1554C8.38026 10.5203 8.60473 10.8512 8.887 11.129M3 17L19 1M9 15.704C9.6492 15.8972 10.3227 15.9969 11 16C15.182 16 18.764 11.987 20.257 10.038C20.4876 9.74071 20.6127 9.37509 20.6125 8.99883C20.6124 8.62256 20.4869 8.25707 20.256 7.96C19.7313 7.27549 19.1684 6.62112 18.57 6"
                stroke="currentColor"
                stroke-width="0.5"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </div>
          <div class="flex justify-end pt-1">
            <button
              @click="login(matchingPassword)"
              class="bg-blue-700 py-2 px-3 text-sm text-white rounded-md transition duration-300 hover:bg-blue-500"
            >
              Login
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- Alert -->
    <div
      class="bg-opacity items-center justify-center flex transition duration-150 ease-in-out z-[99] absolute top-0 right-0 bottom-0 left-0"
      v-if="matchingPassword.status.value != ''"
    >
      <div class="mx-auto w-full max-w-lg h-max">
        <div>
          <div class="relative bg-white rounded-lg shadow p-10">
            <div v-show="matchingPassword.status.value == 'warning'">
              <div class="p-6 text-center">
                <img src="../../public/images/icon/error.png" class="mx-auto py-4" />
                <h3 class="mb-5 text-lg font-normal text-gray-500">
                  {{ matchingPassword.message.value }}
                </h3>

                <button
                  @click="closeWarning()"
                  class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-10 py-2.5 hover:text-gray-900"
                >
                  OK
                </button>
              </div>
            </div>
            <div v-show="matchingPassword.status.value == 'correct'">
              <div class="p-6 text-center">
                <img
                  src="../../public/images/icon/check-mark.png"
                  class="w-16 mx-auto py-4"
                />
                <h3 class="mb-5 text-lg font-normal text-gray-500">Login Success</h3>

                <button
                  @click="closeWarning()"
                  class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-10 py-2.5 hover:text-gray-900"
                >
                  OK
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style></style>
