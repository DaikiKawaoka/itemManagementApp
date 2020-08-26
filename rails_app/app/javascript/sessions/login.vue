<template>
  <div id="app">
    <el-card class="box-card login">

      <div slot="header" class="clearfix">
        <span>Login</span>
        <el-button style="float: right; padding: 3px 0" type="text">Forget password</el-button>
      </div>

      <el-form label-width="80px">
        <el-form-item label="email">
          <el-input type="email" v-model="user.email"></el-input>
        </el-form-item>
        <el-form-item label="Password">
          <el-input type="password" v-model="user.password"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button style="float: right" type="primary" >Login</el-button>
        </el-form-item>
      </el-form>

    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: {
         email: '',
         password: '',
       },
       errors: ''
    };
  },
}
</script>

<style>
.box-card {
  width: 480px;
}

.login {
  position: relative;
  top: 100px;
  right: 0px;
  bottom: 0px;
  left: 0px;
  margin: auto;
}
</style>