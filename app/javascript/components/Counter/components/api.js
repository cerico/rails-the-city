import { useState } from "react";

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

export default () => {
  const [results, setResults] = useState([]);

  const increment = async (score, scores) => {
    const data = { name: 'anonymous', value: score }
    const endpoint = `${apiBase}/api/v1/counters/update`
    const response = await makePostRequest(endpoint, data)
    const result = await response.json()
    try {
      const newScores = [ ...scores, result].sort((a, b) => b.value - a.value).slice(0,10)
      console.log(newScores)
      setResults(newScores)
    } catch (error) {
      console.log(error)
    }
  }
  return { increment, results };
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