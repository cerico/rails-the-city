export const apiBase = window.location.href

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

export async function increment(counter) {
    console.log(counter)
    const data = { name: 'anonymous', value: counter }
    console.log(data)
    const endpoint = `${apiBase}/api/v1/counters/update`
    // return async dispatch => {
      const response = await makePostRequest(endpoint, data)
      const result = await response.json()
      try {
          console.log(result)
        return result
        // dispatch({ type: 'INCREMENT', result})
      } catch (error) {
        console.log(error)
      }
    // };
  }