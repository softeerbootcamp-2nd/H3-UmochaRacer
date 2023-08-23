import React, {createContext, useContext, useReducer} from 'react';

export const INIT_DATA = 'INIT_DATA';
export const CLICK_WORD = 'CLICK_WORD';
export const CLOSE_MODAL = 'CLOSE_MODAL';
export const TOGGLE_CARDB = 'TOGGLE_CARDB';

interface CardbData {
  keyword: string;
  description: string;
  imgSrc: string | null;
}

interface CardbState {
  dataObject: CardbData;
  modalOpen: boolean;
  cardbOn: boolean;
}

interface CardbAction {
  type: 'INIT_DATA' | 'CLICK_WORD' | 'CLOSE_MODAL' | 'TOGGLE_CARDB';
  payload?: {
    dataObject?: CardbData;
  };
}

const initialState: CardbState = {
  dataObject: {
    keyword: '',
    description: '',
    imgSrc: null,
  },
  modalOpen: false,
  cardbOn: false,
};

type CardbDispatch = (action: CardbAction) => void;

const carDictReducer = (state: CardbState, action: CardbAction): CardbState => {
  switch (action.type) {
    case 'INIT_DATA': {
      const newDataObject = action.payload?.dataObject ?? {
        keyword: '',
        description: '',
        imgSrc: null,
      };
      return {
        ...state,
        dataObject: newDataObject,
      };
    }
    case 'CLICK_WORD': {
      const clickedData = action.payload?.dataObject ?? {
        keyword: '',
        description: '',
        imgSrc: null,
      };

      return {
        ...state,
        dataObject: clickedData,
        modalOpen: true,
      };
    }
    case 'CLOSE_MODAL':
      return {
        ...state,
        modalOpen: false,
      };
    case 'TOGGLE_CARDB':
      return {
        ...state,
        modalOpen: false,
        cardbOn: !state.cardbOn,
      };
    default:
      return state;
  }
};

const CardbStateContext = createContext<CardbState | undefined>(undefined);
const CardbDispatchContext = createContext<CardbDispatch | undefined>(
  undefined,
);

export const useCardbState = () => {
  const state = useContext(CardbStateContext);
  if (!state) throw new Error('Cannot find CardbContext');
  return state;
};

export const useCardbDispatch = () => {
  const dispatch = useContext(CardbDispatchContext);
  if (!dispatch) throw new Error('Cannot find CardbContext');
  return dispatch;
};

export const CardbProvider = ({children}: {children: React.ReactNode}) => {
  const [state, dispatch] = useReducer(carDictReducer, initialState);

  return (
    <CardbStateContext.Provider value={state}>
      <CardbDispatchContext.Provider value={dispatch}>
        {children}
      </CardbDispatchContext.Provider>
    </CardbStateContext.Provider>
  );
};
