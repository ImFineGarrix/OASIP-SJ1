<script setup>
import { ref, computed } from "vue";
import moment from "moment";
const emits = defineEmits(["detail"]);
const props = defineProps({
  eventList: {
    type: Array,
  },
});

// Contain Date Time to UTC TIMEZONE
const containDate = (i) => {
  let date = moment(i).format("D MMMM YYYY");
  return date.toUpperCase();
};

const containTime = (i) => {
  let time = moment(i).utc(7).format("H:mm");
  return time;
};

const containEndTime = (time, duration) => {
  let end = moment(time).utc(7).add(duration, "m").format("H:mm");
  return end;
};

let filterStatus = ref("all");
let dateStatus = ref("all");
let categoryStatus = ref("all");
let emptyStatus = ref(true);
let selectDate = ref("");

// List Filter
let filterDate = computed(() => {
  let date = props.eventList;
  let filter = [];

  if (filterStatus.value == "all") {
    if (dateStatus.value == "all") {
      filter = date.sort((a, b) => b.eventStartTime.localeCompare(a.eventStartTime));
    } else if (dateStatus.value == "upcoming") {
      date.sort((a, b) => a.eventStartTime.localeCompare(b.eventStartTime));
      date.forEach((event) => {
        if (moment(event.eventStartTime) > moment()) {
          filter.push(event);
        }
      });
    } else if (dateStatus.value == "past") {
      date.sort((a, b) => b.eventStartTime.localeCompare(a.eventStartTime));
      date.forEach((event) => {
        if (moment(event.eventStartTime) < moment()) {
          filter.push(event);
        }
      });
    }
  } else if (filterStatus.value == "category") {
    date.sort((a, b) => b.eventStartTime.localeCompare(a.eventStartTime));
    date.forEach((event) => {
      if (categoryStatus.value == "all") {
        filter.push(event);
      } else if (categoryStatus.value == "project") {
        if (event.eventCategoryName == "Project Management Clinic") {
          filter.push(event);
        }
      } else if (categoryStatus.value == "devops") {
        if (event.eventCategoryName == "DevOps/Infra Clinic") {
          filter.push(event);
        }
      } else if (categoryStatus.value == "database") {
        if (event.eventCategoryName == "Database Clinic") {
          filter.push(event);
        }
      } else if (categoryStatus.value == "client") {
        if (event.eventCategoryName == "Client-side Clinic") {
          filter.push(event);
        }
      } else if (categoryStatus.value == "server") {
        if (event.eventCategoryName == "Server-side Clinic") {
          filter.push(event);
        }
      }
    });
  } else if (filterStatus.value == "date") {
    date.sort((a, b) => a.eventStartTime.localeCompare(b.eventStartTime));
    if (selectDate.value != "") {
      date.forEach((event) => {
        if (
          moment(event.eventStartTime).format("DD MM YYYY") ==
          moment(selectDate.value).format("DD MM YYYY")
        ) {
          filter.push(event);
        }
      });
    } else {
      filter = date;
    }
  }

  if (filter.length != 0) {
    emptyStatus.value = false;
  } else {
    emptyStatus.value = true;
  }
  return filter;
});

// reset Filter
const resetFilter = () => {
  dateStatus.value = "all";
  categoryStatus.value = "all";
  selectDate.value = "";
};

// Show Detail
let showDetail = ref(false);
const openDetails = (event) => {
  showDetail.value = true;
  emits("detail", event, showDetail);
};
</script>

<template>
  <div class="font-poppin">
    <!-- List Header -->
    <div class="bg-[#001633] pl-10 w-full h-80 text-white rounded-bl-[80px]">
      <div>
        <p class="text-[75px] font-bold pt-20 pl-10 ml-32">Schedule Events</p>
        <div class="font-thin ml-20">
          <div class="space-x-5 px-5 rounded-full h-12 w-max ml-40">
            <span class="font-light">Filter By</span>
            <button
              :class="
                filterStatus == 'all'
                  ? 'py-1 px-10 rounded-full bg-white text-[#0D1B2A] '
                  : 'py-1 px-10 border border-white rounded-full transition duration-500 hover:bg-white hover:text-[#0D1B2A]'
              "
              @click="filterStatus = 'all'"
            >
              All Events
            </button>
            <button
              :class="
                filterStatus == 'category'
                  ? 'py-1 px-10 rounded-full bg-white text-[#0D1B2A]'
                  : 'py-1 px-10 border border-white rounded-full transition duration-500 hover:bg-white hover:text-[#0D1B2A]'
              "
              @click="filterStatus = 'category'"
            >
              Category
            </button>
            <button
              :class="
                filterStatus == 'date'
                  ? 'py-1 px-10 rounded-full bg-white text-[#0D1B2A]'
                  : 'py-1 px-10 border border-white rounded-full transition duration-500 hover:bg-white hover:text-[#0D1B2A]'
              "
              @click="filterStatus = 'date'"
            >
              Date
            </button>
          </div>
          <img
            src="/public/images/illustration/meeting2.png"
            class="ml-[750px] -mt-[150px] w-3/12"
          />
        </div>
      </div>
    </div>

    <!-- Filter All Event Date And Category -->
    <div v-show="eventList != 0 && filterStatus == 'all'">
      <div class="w-10/12 rounded-lg ml-[65%] mt-10 flex space-x-3">
        <select
          class="px-1 border-b border-gray-900 text-left leading-4 w-2/12 text-base text-gray-600 py-2 cursor-pointer"
          v-model="dateStatus"
        >
          <option value="all">All Events</option>
          <option value="upcoming">Upcoming Events</option>
          <option value="past">Past Events</option>
        </select>

        <button
          @click="resetFilter"
          class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-5 py-2.5 hover:text-gray-900"
        >
          Reset Filter
        </button>
      </div>
    </div>
    <div v-show="eventList != 0 && filterStatus == 'category'">
      <div class="w-10/12 rounded-lg ml-[65%] mt-10 flex space-x-3">
        <select
          class="px-1 border-b border-gray-900 text-left leading-4 w-2/12 text-base text-gray-600 py-2 cursor-pointer"
          v-model="categoryStatus"
        >
          <option value="all">All Category</option>
          <option value="project">Project-Management-Clinic</option>
          <option value="devops">Dev-Ops-Clinic</option>
          <option value="database">Database-Clinic</option>
          <option value="client">Client-Side-Clinic</option>
          <option value="server">Server-Side-Clinic</option>
        </select>

        <button
          @click="resetFilter"
          class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-5 py-2.5 hover:text-gray-900"
        >
          Reset Filter
        </button>
      </div>
    </div>
    <div v-show="eventList != 0 && filterStatus == 'date'">
      <div class="w-10/12 rounded-lg ml-[65%] mt-10 flex space-x-3">
        <input
          class="px-1 border-b border-gray-900 text-left leading-4 w-2/12 text-base text-gray-600 py-2 cursor-pointer"
          type="date"
          placeholder="Date"
          v-model="selectDate"
        />

        <button
          @click="resetFilter"
          class="text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-5 py-2.5 hover:text-gray-900"
        >
          Reset Filter
        </button>
      </div>
    </div>

    <!-- List Events -->
    <div class="mt-6" v-if="filterDate != 0">
      <div class="py-2 px-8 overflow-auto max-h-96 scroll">
        <table class="w-10/12 mx-auto">
          <thead class="border-b border-gray-300">
            <tr class="text-base font-semibold text-gray-500">
              <th scope="col" class="px-6 py-4 text-left">Category & Name</th>
              <th scope="col" class="px-6 py-4">Date</th>
              <th scope="col" class="px-6 py-4">Time</th>
              <th scope="col" class="px-6 py-4">Duration</th>
              <th scope="col" class="px-6 py-4">Detail</th>
            </tr>
          </thead>
          <tbody>
            <tr
              class="border-b border-gray-300"
              v-for="(event, index) in filterDate"
              :key="index"
            >
              <td class="px-6 py-5 text-sm font-medium text-gray-900 flex">
                <div
                  class="w-10 h-10 bg-blue-500 rounded flex items-center justify-center text-white"
                  v-if="event.eventCategoryName == 'Project Management Clinic'"
                >
                  PM
                </div>
                <div
                  class="w-10 h-10 bg-emerald-500 rounded flex items-center justify-center text-white"
                  v-else-if="event.eventCategoryName == 'DevOps/Infra Clinic'"
                >
                  DO
                </div>
                <div
                  class="w-10 h-10 bg-rose-500 rounded flex items-center justify-center text-white"
                  v-else-if="event.eventCategoryName == 'Database Clinic'"
                >
                  DB
                </div>
                <div
                  class="w-10 h-10 bg-cyan-500 rounded flex items-center justify-center text-white"
                  v-else-if="event.eventCategoryName == 'Client-side Clinic'"
                >
                  CS
                </div>
                <div
                  class="w-10 h-10 bg-amber-500 rounded flex items-center justify-center text-white"
                  v-else-if="event.eventCategoryName == 'Server-side Clinic'"
                >
                  SS
                </div>
                <div
                  class="w-10 h-10 bg-slate-500 rounded flex items-center justify-center text-white"
                  v-else
                >
                  ##
                </div>
                <div class="pl-5">
                  <p class="text-lg font-semibold leading-none text-gray-900 pb-2">
                    {{ event.eventCategoryName }}
                  </p>
                  <p class="text-sm leading-3 text-gray-500">{{ event.bookingName }}</p>
                </div>
              </td>
              <td class="text-sm text-gray-900 font-semibold px-6 py-4 text-center">
                {{ containDate(event.eventStartTime) }}
              </td>
              <td class="text-sm text-gray-900 font-semibold px-6 py-4 text-center">
                {{ containTime(event.eventStartTime) }} -
                {{ containEndTime(event.eventStartTime, event.eventDuration) }}
              </td>
              <td class="text-sm text-gray-900 font-semibold px-6 py-4 text-center">
                {{ event.eventDuration }} MIN
              </td>
              <td class="px-6 py-4 flex">
                <button
                  class="items-center justify-center mx-auto content-center text-gray-500 bg-white hover:bg-gray-100 rounded-lg border border-gray-500 text-sm font-medium px-5 py-2.5 hover:text-gray-900"
                  @click="openDetails(event)"
                >
                  detail
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Empty Events -->

    <div v-if="eventList == 0 || emptyStatus == true">
      <div class="py-24 mx-auto w-8/12">
        <div class="h-max bg-white rounded mx-auto">
          <img
            src="../../public/images/illustration/noevent.png"
            class="w-4/12 mx-auto"
          />
          <h1 class="text-center font-semibold text-lg text-gray-400 py-5">
            No Event Schedule
          </h1>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.bg-opacity {
  background-color: rgba(0, 0, 0, 0.3);
}
</style>
