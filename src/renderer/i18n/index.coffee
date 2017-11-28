import Vue from 'vue'
import VueI18n from 'vue-i18n'

import cn from './locales/cn.coffee'
import en from './locales/en.coffee'


messages = {
    cn,
    en
}


locale = navigator.language
if locale.indexOf('zh') == 0
    locale = 'cn'


Vue.use(VueI18n)
export default new VueI18n({
    locale,
    messages
})
