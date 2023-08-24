export const fetchData = async (url: string) => {
  try {
    const response = await fetch(import.meta.env.VITE_API_URL + url, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    });

    if (response.ok) {
      const responseData = await response.json();
      const data = responseData.data;
      return data;
    } else {
      throw new Error('Error fetching data');
    }
  } catch (error) {
    throw new Error('Error fetching data');
  }
};
