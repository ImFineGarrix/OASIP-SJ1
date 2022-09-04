<script setup></script>
<template>
  <div class="font-poppin">
    <!-- Navbar Vertical -->

    <div class="w-60">
      <div class="overflow-y-auto py-4 px-3 bg-gray-50 h-screen">
        <ul class="space-y-2">
          <li>
            <router-link
              :to="{ name: 'HomePage' }"
              class="flex items-center p-2 text-base font-normal text-gray-700 rounded-lg hover:text-white hover:bg-gray-700 transition duration-500"
              ><svg
                class="w-4 h-4 mx-2"
                viewBox="0 0 14 13"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M2.75 4.75V12.25H11.25V4.75M0.75 6.25L7 0.75L13.25 6.25"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>

              <span class="ml-3 text-base">Home</span>
            </router-link>
          </li>
          <li>
            <router-link
              :to="{ name: 'UserPage' }"
              class="flex items-center p-2 text-base font-normal text-gray-700 rounded-lg hover:text-white hover:bg-gray-700 transition duration-500"
            >
              <svg
                class="w-4 h-4 mx-2"
                viewBox="0 0 12 13"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M6 7.25C7.79493 7.25 9.25 5.79493 9.25 4C9.25 2.20507 7.79493 0.75 6 0.75C4.20507 0.75 2.75 2.20507 2.75 4C2.75 5.79493 4.20507 7.25 6 7.25Z"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
                <path
                  d="M0.75 12.25C0.75 9.75 2.75 7.25 6 7.25C9.25 7.25 11.25 9.75 11.25 12.25"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>

              <span class="ml-3">User</span>
            </router-link>
          </li>
        </ul>
        <ul class="pt-4 mt-4 space-y-2 border-t border-gray-500">
          <li>
            <router-link
              :to="{ name: 'EventPage' }"
              class="flex items-center p-2 text-base font-normal text-gray-700 rounded-lg hover:text-white hover:bg-gray-700 transition duration-500"
            >
              <svg
                class="w-4 h-4 mx-2"
                viewBox="0 0 14 14"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M0.75 0.75H5.25V5.25H0.75V0.75ZM0.75 8.75H5.25V13.25H0.75V8.75ZM8.75 8.75H13.25V13.25H8.75V8.75ZM8.75 0.75H13.25V5.25H8.75V0.75Z"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>

              <span class="ml-3">Event</span>
            </router-link>
          </li>
          <li>
            <router-link
              :to="{ name: 'AddPage' }"
              class="flex items-center p-2 text-base font-normal text-gray-700 rounded-lg hover:text-white hover:bg-gray-700 transition duration-500"
            >
              <svg
                class="w-4 h-4 mx-2"
                viewBox="0 0 15 15"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M13.8 3.75H8.8M11.3 1.25V6.25M0.75 1.75H5.25V6.25H0.75V1.75ZM0.75 9.75H5.25V14.25H0.75V9.75ZM8.75 9.75H13.25V14.25H8.75V9.75Z"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>

              <span class="ml-3">Add Event</span>
            </router-link>
          </li>
        </ul>
        <ul class="pt-4 mt-4 space-y-2 border-t border-gray-500">
          <li>
            <router-link
              :to="{ name: 'CategoryPage' }"
              class="flex items-center p-2 text-base font-normal text-gray-700 rounded-lg hover:text-white hover:bg-gray-700 transition duration-500"
            >
              <svg
                class="w-4 h-4 mx-2"
                viewBox="0 0 14 14"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M0.75 10L7 13.25L13.25 10M0.75 7L7 10.25L13.25 7M7 0.75L0.75 4L7 7.25L13.25 4L7 0.75Z"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>

              <span class="ml-3">Category</span>
            </router-link>
          </li>
        </ul>
        <ul class="pt-4 mt-4 space-y-2 border-t border-gray-500">
          <li>
            <router-link
              :to="{ name: 'SigninPage' }"
              class="flex items-center p-2 text-base font-normal text-gray-700 rounded-lg hover:text-white hover:bg-gray-700 transition duration-500"
            >
              <svg
                class="w-4 h-4 ml-3 mr-2"
                viewBox="0 0 14 14"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M4.25 1.25H0.75V13.25H4.25M8.25 3.75L4.75 7.25L8.25 10.75M13.25 7.25H4.75"
                  stroke="currentColor"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>

              <span class="ml-3">Sign in</span>
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<style scoped>
.router-link-active {
  color: #ffffff;
  background-color: #374151;
}
</style>
