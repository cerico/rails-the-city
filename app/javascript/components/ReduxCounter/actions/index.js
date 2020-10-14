const apiBase = window.location.href

function headers() {
    return new Headers({
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.getElementsByTagName('meta')['csrf-token'].content
    })
}

export function makePostRequest(endPoint, data) {
  return fetch(endPoint, {
    headers: headers(),
    credentials: 'include',
    method: 'PUT',
    body: JSON.stringify(data),
  })
}

export function increment(counter) {
    const data = { counter: counter }
    const endpoint = `${apiBase}/api/v1/counters/update`
    return async dispatch => {
      const response = await makePostRequest(endpoint, data)
      const result = await response.json()
      try {
        dispatch({ type: 'INCREMENT', result})
      } catch (error) {
        console.log(error)
      }
    };
  }