import {useState, useEffect} from 'react';

interface FetchResult<T> {
  data: T | null;
  error: Error | null;
  loading: boolean;
}

interface ApiResponse<T> {
  data: T;
}

function useFetch<T>(url: string): FetchResult<T> {
  const [data, setData] = useState<T | null>(null);
  const [error, setError] = useState<Error | null>(null);
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    if (!url) return;
    async function fetchData() {
      try {
        const response = await fetch(import.meta.env.VITE_API_URL + url);
        if (!response.ok) {
          throw new Error(`Failed to fetch: ${response.statusText}`);
        }
        const result: ApiResponse<T> = await response.json();
        setData(result.data);
      } catch (error) {
        setError(error as Error);
      } finally {
        setLoading(false);
      }
    }
    fetchData();
  }, [url]);

  return {data, error, loading};
}
export default useFetch;
