<template>
  <div id="app">
    <p id="profile_name">Name: {{user.name}}</p>
    <p id="profile_user_name">UserName: {{user.user_name}}</p>
    <p>Comment: {{ user.comment }}</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      user: {},
    }
  },
  mounted () {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response => (this.user = response.data))
  }
}
</script>

<style scoped>
</style>