import { useEffect, useState } from "react";

export function useScroll() {
  const [scrollPosition, setScrollPosition] = useState<number>(0);
  const [hasScrolled, setHasScrolled] = useState<boolean>(false);

  const updateScroll = () => {
      setScrollPosition(window.scrollY || document.documentElement.scrollTop);
  };

  useEffect(() => {
      if (scrollPosition > 1 && !hasScrolled) {
          window.scrollTo({top: window.innerHeight - 50, behavior: 'smooth'});
          setHasScrolled(true);
      } else if (scrollPosition === 0) {
          setHasScrolled(false);
      }
  }, [scrollPosition, hasScrolled]);

  useEffect(() => {
      window.addEventListener('scroll', updateScroll);
      return () => {
          window.removeEventListener('scroll', updateScroll);
      };
  }, []);

  useEffect(() => {
      window.scrollTo(0, 0);
  }, []);

  return scrollPosition;
}
