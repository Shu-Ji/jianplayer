import Vue from 'vue'
import VueI18n from 'vue-i18n'
import axios from 'axios'

import App from './App'
import router from './router'
import store from './store'
import i18n from './i18n/index.coffee'


if not process.env.IS_WEB
    Vue.use(require('vue-electron'))

Vue.http = Vue.prototype.$http = axios
Vue.config.productionTip = false

new Vue({
    components: { App }
    router
    store
    i18n
    template: '<App/>'
}).$mount('#app')
