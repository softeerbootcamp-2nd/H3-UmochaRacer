import React, {createContext, useContext, useReducer} from 'react';

export const SET_IMAGE_SRC = 'SET_IMAGE_SRC';
export const RESET_IMAGE_SRC = 'RESET_IMAGE_SRC';

interface ImageSrcState {
  imgSrc: string | null;
}

interface ImageSrcAction {
  type: 'SET_IMAGE_SRC' | 'RESET_IMAGE_SRC';
  payload?: {
    imgSrc?: string;
  };
}

const initialState: ImageSrcState = {
  imgSrc: null,
};

type ImageSrcDispatch = (action: ImageSrcAction) => void;

const imageSrcReducer = (
  state: ImageSrcState,
  action: ImageSrcAction,
): ImageSrcState => {
  switch (action.type) {
    case 'SET_IMAGE_SRC': {
      const newImgSrc = action.payload?.imgSrc ?? null;
      return {
        ...state,
        imgSrc: newImgSrc,
      };
    }
    case 'RESET_IMAGE_SRC':
      return {
        ...state,
        imgSrc: null,
      };
    default:
      return state;
  }
};

const ImageSrcStateContext = createContext<ImageSrcState | undefined>(
  undefined,
);
const ImageSrcDispatchContext = createContext<ImageSrcDispatch | undefined>(
  undefined,
);

export const useImageSrcState = () => {
  const state = useContext(ImageSrcStateContext);
  if (!state) throw new Error('Cannot find ImageSrcContext');
  return state;
};

export const useImageSrcDispatch = () => {
  const dispatch = useContext(ImageSrcDispatchContext);
  if (!dispatch) throw new Error('Cannot find ImageSrcContext');
  return dispatch;
};

export const ImageSrcProvider = ({children}: {children: React.ReactNode}) => {
  const [state, dispatch] = useReducer(imageSrcReducer, initialState);

  return (
    <ImageSrcStateContext.Provider value={state}>
      <ImageSrcDispatchContext.Provider value={dispatch}>
        {children}
      </ImageSrcDispatchContext.Provider>
    </ImageSrcStateContext.Provider>
  );
};
