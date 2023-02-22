
function [ORePRR] = calcTheorORePRR(tau,NRc,NSeO,prr1,prr2,prr3,prr4,prr5,prr6,prr7,prr8)

result1 = zeros(1,length(prr1));
for i = 1:ceil(NSeO/2)
    if NSeO == 2
        result1 = result1 + nchoosek(ceil(NSeO/2),i)*(prr2.^i).*(1-prr2).^(ceil(NSeO/2)-i);
    elseif NSeO == 3
        result1 = result1 + nchoosek(ceil(NSeO/2),i)*(prr3.^i).*(1-prr3).^(ceil(NSeO/2)-i);
    elseif NSeO == 4
        result1 = result1 + nchoosek(ceil(NSeO/2),i)*(prr4.^i).*(1-prr4).^(ceil(NSeO/2)-i);
    elseif NSeO == 5
        result1 = result1 + nchoosek(ceil(NSeO/2),i)*(prr5.^i).*(1-prr5).^(ceil(NSeO/2)-i);
    elseif NSeO == 6
        result1 = result1 + nchoosek(ceil(NSeO/2),i)*(prr6.^i).*(1-prr6).^(ceil(NSeO/2)-i);
    elseif NSeO == 7
        result1 = result1 + nchoosek(ceil(NSeO/2),i)*(prr7.^i).*(1-prr7).^(ceil(NSeO/2)-i);
    elseif NSeO == 8
        result1 = result1 + nchoosek(ceil(NSeO/2),i)*(prr8.^i).*(1-prr8).^(ceil(NSeO/2)-i);
    end
end

result2 = zeros(1,length(prr1));
for i = 1:floor(NSeO/2)
    for j = 1:ceil(NSeO/2)
        %result2 = result2 + nchoosek(floor(NSeO/2),floor(NSeO/2)-i)*nchoosek(ceil(NSeO/2),ceil(NSeO/2)-j)*(prr1.^i)*(1-prr1).^(floor(NSeO/2)-1)*(prr2.^j)*(1-prr2).^(ceil(NSeO/2)-j);
        if NSeO == 2
            result2 = result2 + nchoosek(floor(NSeO/2),floor(NSeO/2)-i)*nchoosek(ceil(NSeO/2),ceil(NSeO/2)-j)*(prr1.^i).*(1-prr1).^(floor(NSeO/2)-i).*(prr2.^j).*(1-prr2).^(ceil(NSeO/2)-j);
        elseif NSeO == 3
            result2 = result2 + nchoosek(floor(NSeO/2),floor(NSeO/2)-i)*nchoosek(ceil(NSeO/2),ceil(NSeO/2)-j)*(prr2.^i).*(1-prr2).^(floor(NSeO/2)-i).*(prr3.^j).*(1-prr3).^(ceil(NSeO/2)-j);
        elseif NSeO == 4
            result2 = result2 + nchoosek(floor(NSeO/2),floor(NSeO/2)-i)*nchoosek(ceil(NSeO/2),ceil(NSeO/2)-j)*(prr2.^i).*(1-prr2).^(floor(NSeO/2)-i).*(prr4.^j).*(1-prr4).^(ceil(NSeO/2)-j);
        elseif NSeO == 5
            result2 = result2 + nchoosek(floor(NSeO/2),floor(NSeO/2)-i)*nchoosek(ceil(NSeO/2),ceil(NSeO/2)-j)*(prr3.^i).*(1-prr3).^(floor(NSeO/2)-i).*(prr5.^j).*(1-prr5).^(ceil(NSeO/2)-j);
        elseif NSeO == 6
            result2 = result2 + nchoosek(floor(NSeO/2),floor(NSeO/2)-i)*nchoosek(ceil(NSeO/2),ceil(NSeO/2)-j)*(prr3.^i).*(1-prr3).^(floor(NSeO/2)-i).*(prr6.^j).*(1-prr6).^(ceil(NSeO/2)-j);
        elseif NSeO == 7
            result2 = result2 + nchoosek(floor(NSeO/2),floor(NSeO/2)-i)*nchoosek(ceil(NSeO/2),ceil(NSeO/2)-j)*(prr4.^i).*(1-prr4).^(floor(NSeO/2)-i).*(prr7.^j).*(1-prr7).^(ceil(NSeO/2)-j);
        elseif NSeO == 8
            result2 = result2 + nchoosek(floor(NSeO/2),floor(NSeO/2)-i)*nchoosek(ceil(NSeO/2),ceil(NSeO/2)-j)*(prr4.^i).*(1-prr4).^(floor(NSeO/2)-i).*(prr8.^j).*(1-prr8).^(ceil(NSeO/2)-j);
        end
    end
end


ORePRR = (NRc/(tau + 1))*result1 + ((tau + 1 - NRc)/(tau+1))*result2;


end























