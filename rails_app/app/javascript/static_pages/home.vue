<template>
  <div id="app">
    <header-page></header-page>
  </div>
</template>
<script>

import axios from "axios";
import HeaderPage from '../layouts/header.vue';
// import {reject, filter} from 'lodash';
export default {
  data() {
    return {

    };
  },
  components: {
    HeaderPage,
  }
};
</script>