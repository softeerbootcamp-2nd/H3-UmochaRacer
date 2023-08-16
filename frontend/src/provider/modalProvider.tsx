import React, {createContext, useContext, ReactNode, useState} from 'react';

export type ModalType =
  | 'exit'
  | 'model_change'
  | 'powertrain_change'
  | 'type_change'
  | 'mode_to_self'
  | 'mode_to_guide'
  | null;

interface ModalContextType {
  isVisible: boolean;
  activeModal: ModalType;
  openModal: (type: ModalType) => void;
  closeModal: () => void;
}

const ModalContext = createContext<ModalContextType | undefined>(undefined);

interface ModalProviderProps {
  children: ReactNode;
}

export const ModalProvider: React.FC<ModalProviderProps> = ({children}) => {
  const [isVisible, setIsVisible] = useState(false);
  const [activeModal, setActiveModal] = useState<ModalType>(null);

  function openModal(type: ModalType) {
    setActiveModal(type);
    setIsVisible(true);
  }

  function closeModal() {
    setIsVisible(false);
    setActiveModal(null);
  }

  return (
    <ModalContext.Provider
      value={{isVisible, activeModal, openModal, closeModal}}
    >
      {children}
    </ModalContext.Provider>
  );
};

export function useModalContext() {
  const context = useContext(ModalContext);
  if (!context) {
    throw new Error('useModalContext must be used within a ModalProvider');
  }
  return context;
}