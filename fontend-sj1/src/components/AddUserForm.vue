<script setup>
import { ref, computed } from "vue";
import moment from "moment";
const emits = defineEmits(["add"]);
const props = defineProps({
  users: {
    type: Array,
    default: [],
  },
  statusInsert: {
    type: Object,
  },
});

// let type = ref(null);
// Current Detail
const addUser = computed(() => {
  return {
    name: ref(""),
    email: ref(""),
    role: ref("student"),
    password: ref(""),
    confirmPassword: ref(""),
    status: ref(props.statusInsert),
  };
});

const closeAddUser = () => {
  addUser.value.status.value = false;
};

let warningStatus = ref("");
let msg = ref("");
// check add
const addNewUser = (user) => {
  let name = user.name.value.trim();
  let password = user.password.value;
  let confirm = user.confirmPassword.value;
  if (name == "") {
    msg.value = "Please fill your name";
    warningStatus.value = "warning";
  } else if (user.email.value == "") {
    msg.value = "Please fill your email";
    warningStatus.value = "warning";
  } else if (
    !user.email.value.match(
      /^([a-zA-Z0-9._-])+@\w+([a-zA-Z0-9._-])*(\.[a-zA-Z0-9_-]{2,10})+$/
    )
  ) {
    msg.value = "Please provide a valid email address";
    warningStatus.value = "warning";
  } else if (password == "") {
    msg.value = "Please fill you password";
    warningStatus.value = "warning";
  } else if (password.length < 8 || password.length > 14) {
    msg.value = "Please password length 8 between 14";
    warningStatus.value = "warning";
  } else if (password != confirm) {
    msg.value = "The password confirmation does not match";
    warningStatus.value = "warning";
    addUser.value.confirmPassword.value = "";
  } else {
    if (duplicate(user, name) == "duplicateName") {
      msg.value = "Please not duplicate the name";
      warningStatus.value = "warning";
    } else if (duplicate(user, name) == "duplicateEmail") {
      msg.value = "Please not duplicate the email";
      warningStatus.value = "warning";
    } else {
      warningStatus.value = "correct";
      emits("add", user, name, password);
    }
  }
};

const duplicate = (user, name) => {
  let status = "";
  for (let i = 0; props.users.length > i; i++) {
    if (props.users[i].name == name) {
      status = "duplicateName";
      break;
    } else if (props.users[i].email == user.email.value) {
      status = "duplicateEmail";
      break;
    } else {
      status = "correct";
    }
  }
  return status;
};

const warningCorrectClose = () => {
  warningStatus.value = "";
  addUser.value.status.value = false;
  addUser.value.name.value = "";
  addUser.value.email.value = "";
  addUser.value.password.value = "";
  addUser.value.confirmation.value = "";
};
</script>

<template>
  <div class="font-poppin" v-if="addUser.status.value == true">
    <!-- Add Event -->
    <div
      class="bg-opacity items-center justify-center flex transition duration-150 ease-in-out z-10 absolute top-0 right-0 bottom-0 left-0"
    >
      <div class="mx-auto w-full max-w-xl h-max">
        <div class="relative bg-white rounded-lg shadow p-10">
          <div class="p-5 space-y-6">
            <div class="ml-3 text-4xl font-bold text-gray-900 uppercase flex">
              ADD USER
            </div>
            <div class="space-y-6">
              <div class="flex space-x-5 leading-none justify-center items-center">
                <svg
                  width="20"
                  height="20"
                  viewBox="0 0 24 24"
                  version="1.1"
                  xmlns="http://www.w3.org/2000/svg"
                  xmlns:xlink="http://www.w3.org/1999/xlink"
                  class="-mt-3"
                >
                  <title />
                  <g
                    fill="none"
                    fill-rule="evenodd"
                    id="页面-1"
                    stroke="none"
                    stroke-width="1"
                  >
                    <g transform="translate(-25.000000, -207.000000)">
                      <g transform="translate(25.000000, 207.000000)">
                        <rect
                          fill="#FFFFFF"
                          fill-opacity="0.01"
                          fill-rule="nonzero"
                          height="24"
                          width="24"
                          x="0"
                          y="0"
                        />
                        <path
                          d="M12,10 C13.933,10 15.5,8.433 15.5,6.5 C15.5,4.567005 13.933,3 12,3 C10.067,3 8.5,4.567005 8.5,6.5 C8.5,8.433 10.067,10 12,10 Z"
                          id="路径"
                          stroke="#212121"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="1.5"
                        />
                        <path
                          d="M3,20.4 L3,21 L21,21 L21,20.4 C21,18.1598 21,17.0397 20.56405,16.18405 C20.18055,15.4314 19.5686,14.81945 18.81595,14.43595 C17.9603,14 16.8402,14 14.6,14 L9.4,14 C7.1598,14 6.0397,14 5.18405,14.43595 C4.43139,14.81945 3.819465,15.4314 3.435975,16.18405 C3,17.0397 3,18.1598 3,20.4 Z"
                          id="路径"
                          stroke="#212121"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="1.5"
                        />
                      </g>
                    </g>
                  </g>
                </svg>
                <div>
                  <input
                    class="p-2 border-b border-gray-400 leading-4 text-base placeholder-gray-600 w-96 h-max peer"
                    type="text"
                    placeholder="name"
                    v-model="addUser.name.value"
                    maxlength="100"
                    required
                  />

                  <p class="text-red-500 text-sm py-1 invisible peer-invalid:visible">
                    * Please fill your name
                  </p>
                  <p class="float-right text-sm leading-4 text-gray-600 -mt-5">
                    {{ addUser.name.value.length }} / 100
                  </p>
                </div>
              </div>

              <div class="flex space-x-5 leading-none justify-center items-center">
                <svg
                  class="fill-stroke -mt-3"
                  width="20"
                  height="20"
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
                <div>
                  <input
                    class="p-2 border-b border-gray-400 leading-4 text-base placeholder-gray-600 w-96 h-max peer"
                    type="email"
                    placeholder="email"
                    v-model="addUser.email.value"
                    maxlength="50"
                    required
                  />
                  <p class="text-red-500 text-sm py-1 invisible peer-invalid:visible">
                    * Please provide a valid email
                  </p>
                  <p class="float-right text-sm leading-4 text-gray-600 -mt-5">
                    {{ addUser.email.value.length }} / 50
                  </p>
                </div>
              </div>
              <div class="flex space-x-5 leading-none justify-center items-center">
                <svg
                  class="-mt-4"
                  width="20"
                  height="20"
                  viewBox="0 0 39 38"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M28.4 13.6999C30.5539 13.6999 32.3 11.9538 32.3 9.7999C32.3 7.64599 30.5539 5.8999 28.4 5.8999C26.2461 5.8999 24.5 7.64599 24.5 9.7999C24.5 11.9538 26.2461 13.6999 28.4 13.6999Z"
                    stroke="currentColor"
                    stroke-width="2.5"
                  />
                  <path
                    d="M15.4 15.3999C14.6354 12.9216 14.7333 10.2574 15.6777 7.84193C16.6221 5.42647 18.3573 3.40236 20.6 2.09988C22.8561 0.802468 25.4905 0.322804 28.0591 0.741791C30.6277 1.16078 32.9732 2.45278 34.7 4.39988C36.4204 6.32825 37.4292 8.78723 37.5588 11.3682C37.6884 13.9493 36.931 16.4969 35.4124 18.5879C33.8938 20.6789 31.7054 22.1874 29.2109 22.8626C26.7165 23.5379 24.066 23.3393 21.7 22.2999M15.4 15.3999L0.5 31.9999V37.3999H6.6L7.3 33.1999L13.8 32.7999L14.3 27.2999L19.8 27.1999L21.6 22.3999"
                    stroke="currentColor"
                    stroke-width="2.5"
                  />
                </svg>

                <div>
                  <input
                    class="p-2 border-b border-gray-400 leading-4 text-base placeholder-gray-600 w-96 h-max peer"
                    type="password"
                    placeholder="password"
                    v-model="addUser.password.value"
                    minlength="8"
                    required
                  />
                  <p class="text-red-500 text-sm py-1 invisible peer-invalid:visible">
                    * Please password length 8 between 14
                  </p>
                </div>
              </div>
              <div class="flex space-x-5 leading-none justify-center items-center">
                <svg
                  class="-mt-4"
                  width="20"
                  height="20"
                  viewBox="0 0 39 38"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M28.4 13.6999C30.5539 13.6999 32.3 11.9538 32.3 9.7999C32.3 7.64599 30.5539 5.8999 28.4 5.8999C26.2461 5.8999 24.5 7.64599 24.5 9.7999C24.5 11.9538 26.2461 13.6999 28.4 13.6999Z"
                    stroke="currentColor"
                    stroke-width="2.5"
                  />
                  <path
                    d="M15.4 15.3999C14.6354 12.9216 14.7333 10.2574 15.6777 7.84193C16.6221 5.42647 18.3573 3.40236 20.6 2.09988C22.8561 0.802468 25.4905 0.322804 28.0591 0.741791C30.6277 1.16078 32.9732 2.45278 34.7 4.39988C36.4204 6.32825 37.4292 8.78723 37.5588 11.3682C37.6884 13.9493 36.931 16.4969 35.4124 18.5879C33.8938 20.6789 31.7054 22.1874 29.2109 22.8626C26.7165 23.5379 24.066 23.3393 21.7 22.2999M15.4 15.3999L0.5 31.9999V37.3999H6.6L7.3 33.1999L13.8 32.7999L14.3 27.2999L19.8 27.1999L21.6 22.3999"
                    stroke="currentColor"
                    stroke-width="2.5"
                  />
                </svg>

                <div>
                  <input
                    class="p-2 border-b border-gray-400 leading-4 text-base placeholder-gray-600 w-96 h-max peer"
                    type="password"
                    placeholder="confirm password"
                    v-model="addUser.confirmPassword.value"
                    minlength="8"
                    required
                  />
                </div>
              </div>
              <div class="flex space-x-5 leading-none justify-center items-center">
                <svg
                  class="mt-5"
                  width="20"
                  height="20"
                  viewBox="0 0 24 24"
                  version="1.1"
                  xmlns="http://www.w3.org/2000/svg"
                  xmlns:xlink="http://www.w3.org/1999/xlink"
                >
                  <title />
                  <g
                    fill="none"
                    fill-rule="evenodd"
                    stroke="none"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1"
                  >
                    <g
                      stroke="#212121"
                      stroke-width="1.5"
                      transform="translate(-28.000000, -272.000000)"
                    >
                      <g transform="translate(28.000000, 272.000000)">
                        <g transform="translate(1.000000, 4.000000)">
                          <polygon points="0 2.75 11 0 22 2.75 11 5.5" />
                          <path
                            d="M4.95,4.4 L4.95,9.88383 C4.95,9.88383 7.7,11.55 11,11.55 C14.3,11.55 17.05,9.88383 17.05,9.88383 L17.05,4.4"
                          />
                          <line x1="1.65" x2="1.65" y1="3.3" y2="15.4" />
                          <rect height="3.3" width="3.3" x="0" y="14.3" />
                        </g>
                      </g>
                    </g>
                  </g>
                </svg>
                <select
                  v-model="addUser.role.value"
                  class="px-1 border-b border-gray-200 text-left leading-4 text-base text-gray-600 py-4 w-96 cursor-pointer"
                >
                  <option value="student">Student</option>
                  <option value="admin">Admin</option>
                  <option value="lecturer">Lecturer</option>
                </select>
              </div>
              <div class="flex justify-center items-center">
                <button
                  @click="addNewUser(addUser)"
                  class="mt-2 text-base font-medium leading-4 py-4 w-full text-white bg-blue-900 transition duration-500 ease-in-out hover:bg-blue-700"
                >
                  Add User
                </button>
              </div>
            </div>
          </div>
          <button
            @click="closeAddUser()"
            class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center"
          >
            <svg
              class="w-5 h-5"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"
              ></path>
            </svg>
          </button>
        </div>
      </div>
    </div>

    <!-- Alert -->
    <div
      class="bg-opacity items-center justify-center flex transition duration-150 ease-in-out z-[99] absolute top-0 right-0 bottom-0 left-0"
      v-if="warningStatus != ''"
    >
      <div class="mx-auto w-full max-w-lg h-max">
        <div>
          <div class="relative bg-white rounded-lg shadow p-10">
            <div v-show="warningStatus == 'warning'">
              <div class="p-6 text-center">
                <img src="../../public/images/icon/error.png" class="mx-auto py-4" />
                <h3 class="mb-5 text-lg font-normal text-gray-500">{{ msg }}</h3>

                <button
                  @click="warningStatus = ''"
                  class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-10 py-2.5 hover:text-gray-900"
                >
                  OK
                </button>
              </div>
            </div>
            <div v-show="warningStatus == 'correct'">
              <div class="p-6 text-center">
                <img
                  src="../../public/images/icon/check-mark.png"
                  class="w-16 mx-auto py-4"
                />
                <h3 class="mb-5 text-lg font-normal text-gray-500">Add User Complete</h3>

                <button
                  @click="warningCorrectClose()"
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
