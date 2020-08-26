<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import staticHome from 'static_pages/home.vue'
import userShow from 'users/show.vue'
import userNew from 'users/new.vue'
import userForm from 'users/form.vue'


const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/',
      component: staticHome  },
    { path: '/users/:id(\\d+)',  // :id は数値のみに制限する
      component: userShow  },
    { path: '/users/new',
      component: userNew  },
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>