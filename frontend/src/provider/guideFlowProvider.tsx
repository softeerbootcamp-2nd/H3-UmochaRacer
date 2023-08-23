import React, {createContext, useContext, useEffect, useReducer} from 'react';
import {fetchData} from '@/api/fetchData';
import {postFetchData} from '@/api/postFetchData';

export const INIT_DATA = 'INIT_DATA';
export const UPDATE_AGE = 'UPDATE_AGE';
export const UPDATE_GENDER = 'UPDATE_GENDER';
export const UPDATE_OPTIONS = 'UPDATE_OPTIONS';
export const GUIDE_TOGGLE = 'GUIDE_TOGGLE';
const UPDATE_RATE = 'UPDATE_RATE';

export interface Tag {
  id: number;
  name: string;
}

export interface GridData {
  category: string;
  tags: Tag[];
}

interface SelectData {
  age?: number;
  gender?: string;
  options?: number[];
}

interface SelectionRate {
  id: number;
  selectionRatio: number;
}

export interface GuideFlowState {
  dataObject: SelectData;
  ages: number[];
  genders: string[];
  optionTag: GridData[];
  showGuide: boolean;
  selectionRateArr: SelectionRate[][];
}

interface GuideFlowAction {
  type:
    | 'INIT_DATA'
    | 'UPDATE_AGE'
    | 'UPDATE_GENDER'
    | 'UPDATE_OPTIONS'
    | 'GUIDE_TOGGLE'
    | 'UPDATE_RATE';
  payload?: {
    dataObject?: SelectData;
    optionTag?: GridData[];
    selectionRateArr?: SelectionRate[][];
  };
}

const initialState: GuideFlowState = {
  dataObject: {age: 0, gender: '', options: []},
  ages: [20, 30, 40, 50, 60, 70],
  genders: ['FEMALE', 'MALE', 'NONE'],
  optionTag: [],
  showGuide: false,
  selectionRateArr: [],
};

type GuideFlowDispatch = (action: GuideFlowAction) => void;

const carDictReducer = (
  state: GuideFlowState,
  action: GuideFlowAction,
): GuideFlowState => {
  switch (action.type) {
    case 'INIT_DATA': {
      const newDataObject = action.payload?.dataObject ?? {
        age: 0,
        gender: '',
        options: [],
      };
      return {
        ...state,
        dataObject: newDataObject,
        optionTag: action.payload?.optionTag ?? [],
      };
    }
    case 'UPDATE_AGE': {
      const ageData = action.payload?.dataObject?.age ?? 0;

      return {
        ...state,
        dataObject: {...state.dataObject, age: ageData},
      };
    }
    case 'UPDATE_GENDER': {
      const genderData = action.payload?.dataObject?.gender ?? '';

      return {
        ...state,
        dataObject: {...state.dataObject, gender: genderData},
      };
    }
    case 'UPDATE_OPTIONS': {
      const optionData = action.payload?.dataObject?.options ?? [];

      return {
        ...state,
        dataObject: {...state.dataObject, options: optionData},
      };
    }
    case 'GUIDE_TOGGLE': {
      return {
        ...state,
        showGuide: !state.showGuide,
      };
    }
    case 'UPDATE_RATE': {
      const rateData = action.payload?.selectionRateArr ?? [];

      return {
        ...state,
        selectionRateArr: rateData,
      };
    }
    default:
      return state;
  }
};

const GuideFlowStateContext = createContext<GuideFlowState | undefined>(
  undefined,
);
const GuideFlowDispatchContext = createContext<GuideFlowDispatch | undefined>(
  undefined,
);

export const useGuideFlowState = () => {
  const state = useContext(GuideFlowStateContext);
  if (!state) throw new Error('Cannot find CardbContext');
  return state;
};

export const useGuideFlowDispatch = () => {
  const dispatch = useContext(GuideFlowDispatchContext);
  if (!dispatch) throw new Error('Cannot find CardbContext');
  return dispatch;
};

export const GiudFlowProvider = ({children}: {children: React.ReactNode}) => {
  const [state, dispatch] = useReducer(carDictReducer, initialState);

  const fetchOptionTag = async () => {
    try {
      const response = await fetchData('/guide/tag');
      dispatch({type: 'INIT_DATA', payload: {optionTag: response}});
    } catch (error) {
      console.error('Error fetching car dictionary data:', error);
    }
  };

  const getTags = async (params: object) => {
    const endpoints = [
      '/sale/powertrain/tag',
      '/sale/driving-system/tag',
      '/sale/bodytype/tag',
      '/sale/exterior-color/tag',
      '/sale/interior-color/tag',
      '/sale/wheel/tag',
    ];
    return Promise.all(
      endpoints.map(async (url: string) => {
        return postFetchData(url, params);
      }),
    );
  };

  useEffect(() => {
    fetchOptionTag();
  }, []);

  useEffect(() => {
    const fetchTag = async () => {
      if (state.dataObject.options === undefined) return;

      const requestBody = {
        age: state.dataObject.age,
        gender: state.dataObject.gender,
        tag1: state.dataObject.options[0],
        tag2: state.dataObject.options[1],
        tag3: state.dataObject.options[2],
      };

      const selectionRateArr = await getTags(requestBody);

      dispatch({
        type: UPDATE_RATE,
        payload: {selectionRateArr: selectionRateArr},
      });
    };

    if (state.showGuide) {
      fetchTag();
    }
  }, [state.showGuide]);

  return (
    <GuideFlowStateContext.Provider value={state}>
      <GuideFlowDispatchContext.Provider value={dispatch}>
        {children}
      </GuideFlowDispatchContext.Provider>
    </GuideFlowStateContext.Provider>
  );
};
