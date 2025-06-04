import React, { useState } from "react";
import InputCadastro from "../components/InputCadastro";
import TelaSemMenu from "../components/TelaSemMenu";
import CamposCadastroLivro from "../dados/CamposCadastroLivro.json";




interface Campo {
    label: string;
    type: string;
    name: string;
  }

  interface FormData {
    [key: string]: string | number;
  }
  
  const inputs: Campo[] = CamposCadastroLivro;

function CadastrarLivro() {
      const formData = useState<FormData>({});
    
    return (
    <TelaSemMenu titulo="CadastrarPrefeitura">
      <div className="flex flex-col items-center justify-center w-full h-full gap-6">
        <div className="bg-white p-10 rounded-2xl shadow-lg w-full max-w-md">
          <h2 className="text-2xl font-semibold text-center mb-6">
            Cadastrar Livro
          </h2>
            <form className="flex flex-col gap-4">
            {inputs.map((campo, index) => (
                <div key={index} className="mb-4">
                  <InputCadastro
                    label={campo.label}
                    type={campo.type}
                    name={campo.name}
                  />
                </div>
              ))}
                
              <button
                type="submit"
                className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-xl shadow-sm transition-colors"
              >
                Avançar
              </button>
            </form>
        </div>
      </div>
    </TelaSemMenu>
    );
};

export default CadastrarLivro;