function batchSize = getBatchSize(nPixels)

g = gpuDevice;

batchSize = 2^(floor(log2(8e9))-6)/2^ceil(log2(nPixels));
if isfield(g, 'AvailableMemory')
  batchSize = 3/4 * 2^(floor(log2(g.AvailableMemory))-6)/2^ceil(log2(nPixels));
elseif isfield(g, 'FreeMemory')
  batchSize = 3/4 * 2^(floor(log2(g.FreeMemory))-6)/2^ceil(log2(nPixels));
end

% The calculation was deducted from the following examples
% batchSize = 2^25/2^ceil(log2(nPixels)); % works well on GTX 970 (which has 4 GB memory)
% batchSize = 2^23/2^ceil(log2(nPixels)); % works well on GTX 560 Ti (which has 1 GB memory)
