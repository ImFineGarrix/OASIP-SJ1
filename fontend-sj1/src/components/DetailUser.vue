<script setup>
import { ref, computed } from "vue";
import moment from "moment";
const emits = defineEmits(["delete", "save"]);
const props = defineProps({
  users: {
    type: Array,
  },
  detailList: {
    type: Object,
  },
  statusDetail: {
    type: Object,
  },
});

// Current Detail
const userDetail = computed(() => {
  return {
    id: props.detailList.id,
    name: ref(props.detailList.name),
    email: ref(props.detailList.email),
    role: ref(props.detailList.role),
    createdOn: props.detailList.createdOn,
    updatedOn: ref(props.detailList.updatedOn),
    status: ref(props.statusDetail),
  };
});

const containDateTime = (i) => {
  let date = moment(i).format("D MMMM YYYY - HH:mm");
  return date.toUpperCase();
};

let toggleEdit = ref(false);

// close detail
const closeDetail = () => {
  userDetail.value.status.value = false;
  toggleEdit.value = false;
};

const lengthUserName = computed(() => {
  if (userDetail.value.name.value) {
    return userDetail.value.name.value.length;
  } else return 0;
});

const lengthUserEmail = computed(() => {
  if (userDetail.value.email.value) {
    return userDetail.value.email.value.length;
  } else return 0;
});

let warningStatus = ref("");
let msg = ref("");
// check add
const checkEdit = (user) => {
  let name = user.name.value.trim();
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
  } else {
    if (duplicate(user, name) == "duplicate") {
      msg.value = "Please dulipcate name or email";
      warningStatus.value = "warning";
    } else if (duplicate(user, name) == "correct") {
      warningStatus.value = "correct";
      emits("save", user, name);
    } else {
      if (checkChangeRole(user) == "change") {
        warningStatus.value = "correct";
        emits("save", user, name);
      } else {
        msg.value = "Please change name email or role";
        warningStatus.value = "warning";
      }
    }
  }
};

const duplicate = (user, name) => {
  let status = "";
  for (let i = 0; props.users.length > i; i++) {
    if (props.users[i].id == user.id) {
      if (props.users[i].name == name) {
        if (props.users[i].email == user.email.value) {
          status = "same";
          break;
        } else {
          status = "correct";
        }
      }
      if (props.users[i].email == user.email.value) {
        if (props.users[i].name == name) {
          status = "same";
          break;
        } else {
          status = "correct";
        }
      }
    } else {
      if (props.users[i].name == name) {
        status = "duplicate";
        break;
      } else if (props.users[i].email == user.email.value) {
        status = "duplicate";
        break;
      } else {
        status = "correct";
      }
    }
  }
  return status;
};

const checkChangeRole = (user) => {
  let status = "";
  for (let i = 0; props.users.length > i; i++) {
    if (props.users[i].id == user.id) {
      if (props.users[i].role == user.role.value) {
        status = "noChange";
        break;
      } else {
        status = "change";
        break;
      }
    }
  }
  return status;
};

// delete detail
const deleteUser = (id) => {
  warningStatus.value = "";
  userDetail.value.status.value = false;
  emits("delete", id);
};
</script>

<template>
  <div class="font-poppin">
    <!-- Show Detail -->
    <div
      v-if="userDetail.status.value == true"
      class="bg-opacity items-center justify-center flex transition duration-150 ease-in-out z-10 absolute top-0 right-0 bottom-0 left-0"
    >
      <div class="mx-auto w-full max-w-[60rem] h-max">
        <div class="relative bg-white rounded-lg shadow p-10">
          <div class="p-5 space-y-6 break-all" v-if="toggleEdit == false">
            <div class="grid grid-cols-2 space-x-10">
              <img
                src="/public/images/illustration/profile.png"
                class="w-6/12 ml-[20%]"
              />
              <div class="space-y-5">
                <div class="flex space-x-5 leading-none">
                  <svg
                    width="18"
                    height="18"
                    viewBox="0 0 24 24"
                    version="1.1"
                    xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink"
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
                  <span class="leading-snug w-2/3">{{ userDetail.name.value }}</span>
                </div>
                <div class="flex space-x-5 leading-none">
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
                  <span class="leading-snug w-2/3">{{ userDetail.email.value }}</span>
                </div>
                <div class="grid grid-flow-col auto-cols-max space-x-5 leading-4">
                  <svg
                    width="18"
                    height="18"
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
                  <span>{{ userDetail.role.value }}</span>
                </div>
                <div class="grid grid-flow-col auto-cols-max space-x-5 leading-5">
                  <svg
                    width="18"
                    height="18"
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
                      stroke-width="1"
                    >
                      <g
                        stroke="#212121"
                        stroke-width="1.5"
                        transform="translate(-326.000000, -15.000000)"
                      >
                        <g transform="translate(326.000000, 15.000000)">
                          <g transform="translate(2.000000, 3.000000)">
                            <rect
                              height="15"
                              rx="1"
                              stroke-linejoin="round"
                              width="20"
                              x="0"
                              y="2"
                            />
                            <line id="路径" x1="5" x2="5" y1="0" y2="4" />
                            <line id="路径" x1="10.5" x2="5" y1="8.5" y2="8.5" />
                            <line id="路径" x1="15" x2="5" y1="12.5" y2="12.5" />
                            <line id="路径" x1="15" x2="15" y1="0" y2="4" />
                          </g>
                        </g>
                      </g>
                    </g>
                  </svg>
                  <span>{{ containDateTime(userDetail.createdOn) }}</span>
                </div>
                <div class="grid grid-flow-col auto-cols-max space-x-5 leading-5">
                  <svg
                    width="18"
                    height="18"
                    viewBox="0 0 24 24"
                    version="1.1"
                    xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink"
                  >
                    <title />
                    <g
                      fill="none"
                      fill-rule="evenodd"
                      id="页面-1"
                      stroke="none"
                      stroke-width="1"
                    >
                      <g id="导航图标" transform="translate(-175.000000, -207.000000)">
                        <g id="编组" transform="translate(175.000000, 207.000000)">
                          <rect
                            fill="#FFFFFF"
                            fill-opacity="0.01"
                            fill-rule="nonzero"
                            height="24"
                            id="矩形"
                            width="24"
                            x="0"
                            y="0"
                          />
                          <path
                            d="M9.1419,21.5856 C7.46635,21.08675 5.9749,20.1606 4.793935,18.93345 C5.2345,18.4113 5.5,17.73665 5.5,17 C5.5,15.34315 4.156855,14 2.5,14 C2.399775,14 2.300695,14.0049 2.202995,14.0145 C2.069895,13.3638 2,12.69005 2,12 C2,10.9547 2.160385,9.94685 2.457895,8.9997 C2.471905,8.9999 2.48594,9 2.5,9 C4.156855,9 5.5,7.65685 5.5,6 C5.5,5.52435 5.3893,5.07455 5.1923,4.674995 C6.34875,3.599685 7.76025,2.79495 9.32605,2.36151 C9.8222,3.334035 10.83335,4.000005 12,4.000005 C13.16665,4.000005 14.1778,3.334035 14.67395,2.36151 C16.23975,2.79495 17.65125,3.599685 18.8077,4.674995 C18.6107,5.07455 18.5,5.52435 18.5,6 C18.5,7.65685 19.84315,9 21.5,9 C21.51405,9 21.5281,8.9999 21.5421,8.9997 C21.8396,9.94685 22,10.9547 22,12 C22,12.69005 21.9301,13.3638 21.797,14.0145 C21.6993,14.0049 21.60025,14 21.5,14 C19.84315,14 18.5,15.34315 18.5,17 C18.5,17.73665 18.7655,18.4113 19.20605,18.93345 C18.0251,20.1606 16.53365,21.08675 14.8581,21.5856 C14.4714,20.3759 13.338,19.5 12,19.5 C10.662,19.5 9.5286,20.3759 9.1419,21.5856 Z"
                            id="路径"
                            stroke="#212121"
                            stroke-linejoin="round"
                            stroke-width="1.5"
                          />
                          <path
                            d="M12,15.5 C13.933,15.5 15.5,13.933 15.5,12 C15.5,10.067 13.933,8.5 12,8.5 C10.067,8.5 8.5,10.067 8.5,12 C8.5,13.933 10.067,15.5 12,15.5 Z"
                            id="路径"
                            stroke="#212121"
                            stroke-linejoin="round"
                            stroke-width="1.5"
                          />
                        </g>
                      </g>
                    </g>
                  </svg>
                  <span>{{ containDateTime(userDetail.updatedOn.value) }}</span>
                </div>
              </div>
            </div>

            <div class="grid grid-cols-2 gap-8">
              <button
                @click="toggleEdit = true"
                class="text-white bg-sky-600 hover:bg-sky-800 font-medium rounded-lg text-sm px-5 py-2.5 mr-2"
              >
                edit
              </button>
              <button
                @click="warningStatus = 'delete'"
                class="text-white bg-red-600 hover:bg-red-800 font-medium rounded-lg text-sm px-5 py-2.5 mr-2"
              >
                delete
              </button>
            </div>
          </div>

          <!-- Show Edit in Event Detail -->
          <div class="p-5 space-y-6" v-else>
            <div class="grid grid-cols-2 space-x-10">
              <img
                src="/public/images/illustration/profile.png"
                class="w-6/12 ml-[20%]"
              />
              <div class="space-y-4">
                <div class="leading-none font-medium text-xl space-y-1">
                  <p>Edit Profile</p>
                  <svg
                    width="100"
                    height="3"
                    viewBox="0 0 276 3"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg%22%3E"
                  >
                    <rect width="256" height="3" rx="1.5" fill="#4299E1" />
                    <rect x="262" width="14" height="3" rx="1.5" fill="#4299E1" />
                  </svg>
                </div>
                <div class="flex space-x-5 leading-none">
                  <svg
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    version="1.1"
                    xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink"
                    class="mt-3"
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
                      class="p-2 border-b border-gray-400 leading-4 text-base placeholder-gray-600 w-80 h-max peer"
                      type="text"
                      placeholder="name"
                      v-model="userDetail.name.value"
                      maxlength="100"
                      required
                    />
                    <p class="text-red-500 text-sm py-1 invisible peer-invalid:visible">
                      * Please fill your name
                    </p>
                    <p class="float-right text-sm leading-4 text-gray-600 -mt-5">
                      {{ lengthUserName }} / 100
                    </p>
                  </div>
                </div>
                <div class="flex space-x-5 leading-none">
                  <svg
                    class="fill-stroke mt-3"
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
                      class="p-2 border-b border-gray-400 leading-4 text-base placeholder-gray-600 w-80 h-max peer"
                      type="email"
                      placeholder="email"
                      v-model="userDetail.email.value"
                      maxlength="150"
                      required
                    />
                    <p class="text-red-500 text-sm py-1 invisible peer-invalid:visible">
                      * Please provide a valid email
                    </p>
                    <p class="float-right text-sm leading-4 text-gray-600 -mt-5">
                      {{ userDetail.email.value.length }} / 150
                    </p>
                  </div>
                </div>
                <div class="flex space-x-5 leading-4">
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
                    v-model="userDetail.role.value"
                    class="px-1 border-b border-gray-200 text-left leading-4 text-base text-gray-600 py-4 w-96 cursor-pointer"
                  >
                    <option value="student">Student</option>
                    <option value="admin">Admin</option>
                    <option value="lecturer">Lecturer</option>
                  </select>
                </div>
              </div>
            </div>

            <div class="grid grid-cols-2 gap-5">
              <button
                @click="checkEdit(userDetail)"
                class="text-white bg-emerald-600 hover:bg-emerald-800 font-medium rounded-lg text-sm px-5 py-2.5 mr-2"
              >
                save
              </button>
              <button
                class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-5 py-2.5 hover:text-gray-900"
                @click="toggleEdit = false"
              >
                cancel
              </button>
            </div>
          </div>

          <button
            @click="closeDetail()"
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

      <!-- alert -->
      <div
        class="bg-opacity items-center justify-center flex transition duration-150 ease-in-out z-[99] absolute top-0 right-0 bottom-0 left-0"
        v-if="warningStatus != ''"
      >
        <div class="mx-auto w-full max-w-lg h-max">
          <div>
            <div class="relative bg-white rounded-lg shadow p-10">
              <div v-show="warningStatus == 'delete'">
                <div class="p-6 text-center">
                  <svg
                    class="mx-auto mb-4 w-14 h-14 text-rose-500"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                    ></path>
                  </svg>
                  <h3 class="mb-5 text-lg font-normal text-gray-400">
                    Are you sure you want to delete<br />
                    <div class="flex text-gray-400 justify-center items-center space-x-2">
                      <svg
                        fill="currentColor"
                        width="18"
                        height="18"
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
                            stroke="currentColor"
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
                      <p>{{ userDetail.role.value }}</p>
                    </div>
                    <span
                      >{{ userDetail.name.value }} , {{ userDetail.email.value }} ?</span
                    >
                  </h3>
                  <button
                    @click="deleteUser(userDetail.id)"
                    class="text-white bg-red-600 hover:bg-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2"
                  >
                    Delete
                  </button>
                  <button
                    @click="warningStatus = ''"
                    class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-5 py-2.5 hover:text-gray-900"
                  >
                    Cancel
                  </button>
                </div>
              </div>
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
                  <h3 class="mb-5 text-lg font-normal text-gray-500">
                    Update User Complete
                  </h3>

                  <button
                    @click="(warningStatus = ''), (toggleEdit = false)"
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
  </div>
</template>

<style></style>
