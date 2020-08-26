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
import userEdit from 'users/edit.vue'


const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/',
      component: staticHome  },
    { path: '/users/:id(\\d+)',  // :id は数値のみに制限する
      name: 'userShow',
      component: userShow  },
    { path: '/users/new',
      name: 'userNew',
      component: userNew  },
    { path: '/users/:id(\\d+)/edit',
      name: 'userEdit',
      component: userEdit   },
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>