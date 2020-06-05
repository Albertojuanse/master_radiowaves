function [adaptado,reciproco,pasivo,sin_perdidas, pYsin]=Propiedades_matS(mat) 
    col=size(mat,2);
    row=size(mat,1);

    % Adaptación:
    comprobante_adaptado=0;
    for i=1:col
        for j=1:row
           if (i==j)
              if (abs(mat(i,j))==0)
                  comprobante_adaptado=comprobante_adaptado+1;
              end
           end
        end
    end

    if (comprobante_adaptado==i)
        adaptado=1;
    else
        adaptado=0;
    end

    % Reciprocidad:
    traspuesta=mat.';

    if(mat == traspuesta)
        reciproco = 1;
    else
        reciproco = 0;
    end
    

    % Pasivo:
    mat_hermitica=conj(traspuesta);
    Q = eye(col) - mat*mat_hermitica;
    
    if(Q >= 0)
        pasivo = 1;
    else
        pasivo = 0;
    end

    % Sin perdidas:
    x=sum(abs(mat(1,:).^2))
    if (x>0.999)
        sin_perdidas=1;
    else
        sin_perdidas=0;
    end
    
    %Pasivo y Sin Pérdidas
    if( mat*mat_hermitica == eye(col))
        pYsin = 1;
    else
        pYsin = 0;
    end
end


