inhibit_all_warnings!
use_frameworks!

def shared_pods
    pod 'ModelMapper', :git => 'https://github.com/JustaLab/mapper.git', :branch => 'swift3'
end


target 'StreemNetworking' do
    shared_pods
end

target 'StreemNetworkingTests' do
    shared_pods
end

install! 'cocoapods', :deterministic_uuids => false