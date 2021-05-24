<template>
  <main v-if="!loading">
    <CountrySelect :countries="countries" @get-country="getCountryData" />
    <button
      class="bg-green-700 text-white rounded p-3 mt-10 focus:outline-none hover:bg-green-600"
      v-if="status.Country"
      @click="clearCountryData"
    >
      Clear Country
    </button>
    <DataTitle :dataDate="dataDate" :text="title" />
    <DataBoxes :status="status" />
  </main>

  <main class="flex flex-col align-center justify-center text-center" v-else>
    <div class="text-grey-500 text-3xl mt-10 mb-6">Fetching data...</div>
    <img
      class="w-24 m-auto"
      :src="require('../assets/hourglass.gif')"
      alt="hourglass"
    />
  </main>
</template>

<script>
import { ref } from "vue";
import DataTitle from "@/components/DataTitle.vue";
import DataBoxes from "@/components/DataBoxes.vue";
import CountrySelect from "@/components/CountrySelect.vue";

export default {
  name: "Home",

  components: { DataTitle, DataBoxes, CountrySelect },

  setup() {
    const loading = ref(true);
    let title = ref("Global");
    const dataDate = ref("");
    const status = ref({});
    const countries = ref([]);

    const fetchCovidData = async () => {
      const res = await fetch("https://api.covid19api.com/summary");
      return await res.json();
    };

    const getCountryData = (country) => {
      status.value = country;
      title.value = country.Country;
    };

    const clearCountryData = async () => {
      loading.value = true;
      const data = await fetchCovidData();
      title.value = "Global";
      status.value = data.Global;
      loading.value = false;
    };

    const appSetup = async () => {
      const data = await fetchCovidData();

      dataDate.value = data.Date;
      status.value = data.Global;
      countries.value = data.Countries;
      loading.value = false;
    };

    appSetup();

    return {
      loading,
      title,
      dataDate,
      status,
      countries,
      getCountryData,
      clearCountryData,
    };
  },
};
</script>
