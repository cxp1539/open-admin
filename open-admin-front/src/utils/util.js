import enquireJs from 'enquire.js'

const timeList = [{
  CN: '早上好',
  US: 'Good morning',
}, {
  CN: '上午好',
  US: 'Good morning',
}, {
  CN: '中午好',
  US: 'Good afternoon',
}, {
  CN: '下午好',
  US: 'Good afternoon',
}, {
  CN: '晚上好',
  US: 'Good evening',
}]

export function timeFix() {
  const time = new Date()
  const hour = time.getHours()
  return hour < 9 ?
    timeList[0] : (hour <= 11 ? timeList[1] : (hour <= 13 ? timeList[2] : (hour <= 20 ? timeList[3] : timeList[4])))
}


export function isDef(v) {
  return v !== undefined && v !== null
}

/**
 * Remove an item from an array.
 */
export function remove(arr, item) {
  if (arr.length) {
    const index = arr.indexOf(item)
    if (index > -1) {
      return arr.splice(index, 1)
    }
  }
}

export function isRegExp(v) {
  return _toString.call(v) === '[object RegExp]'
}

export function enquireScreen(call) {
  const handler = {
    match: function () {
      call && call(true)
    },
    unmatch: function () {
      call && call(false)
    }
  }
  enquireJs.register('only screen and (max-width: 767.99px)', handler)
}

const _toString = Object.prototype.toString

export function actionToObject(json) {
  try {
    return JSON.parse(json)
  } catch (e) {
    console.log('err', e.message)
  }
  return []
}