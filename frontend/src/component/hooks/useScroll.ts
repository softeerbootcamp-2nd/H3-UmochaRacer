import {useEffect, useState, useRef} from 'react';

export function useScroll() {
  const scrollPositionRef = useRef<number>(0);
  const [hasScrolled, setHasScrolled] = useState<boolean>(false);

  const updateScroll = () => {
    scrollPositionRef.current =
      window.scrollY || document.documentElement.scrollTop;
    handleScrollEffects();
  };

  const handleScrollEffects = () => {
    if (scrollPositionRef.current > 1 && !hasScrolled) {
      window.scrollTo({top: window.innerHeight - 50, behavior: 'smooth'});
      setHasScrolled(true);
    } else if (scrollPositionRef.current === 0) {
      setHasScrolled(false);
    }
  };

  useEffect(() => {
    window.addEventListener('scroll', updateScroll);
    return () => {
      window.removeEventListener('scroll', updateScroll);
    };
  }, [hasScrolled]);

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  return hasScrolled;
}
