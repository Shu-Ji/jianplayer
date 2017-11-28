import Vue from 'vue'
import VueI18n from 'vue-i18n'

import cn from './locales/cn.coffee'
import en from './locales/en.coffee'


messages = {
    cn,
    en
}


Vue.use(VueI18n)
i18n = new VueI18n({
    locale: 'cn'
    messages
})
export default i18n
