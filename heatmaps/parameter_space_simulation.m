function output=parameter_space_simulation(parametersmatrix, ic_o, t)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Matrix to store outputs %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Pax3 = zeros(1,size(parametersmatrix,1));
    Pax7 = zeros(1,size(parametersmatrix,1));
    Myf5 = zeros(1,size(parametersmatrix,1));
    MyoD = zeros(1,size(parametersmatrix,1));
    MyoG = zeros(1,size(parametersmatrix,1));


    parfor parameterset=1:size(parametersmatrix,1)
        
        % Copy matrix
        P = parametersmatrix(parameterset,:);
        ic = ic_o;
        
        % Check whether the external input is POA or PZA
        
        % Simulation
        [Tx,Yx] = ode23s(@(t,ic) mrfs_network(t,ic,P), t, ic);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Store results of interest %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
        Pax3(parameterset) = Yx(end, 1);
        Pax7(parameterset) = Yx(end, 2);
        Myf5(parameterset) = Yx(end, 3);
        MyoD(parameterset) = Yx(end, 4);
        MyoG(parameterset) = Yx(end, 5);

        
        display(parameterset*100/size(parametersmatrix,1))
    
    end
    
    output.Pax3 = Pax3;
    output.Pax7 = Pax7;
    output.Myf5 = Myf5;
    output.MyoD = MyoD;
    output.MyoG = MyoG;

end