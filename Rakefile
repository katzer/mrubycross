# MIT License
#
# Copyright (c) 2022 Sebastián Katzer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation tasks (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

desc 'Build image'
task :build do
  sh 'docker build -t skatzer/mrubycross:kinetic .'
end

desc 'Shell into container'
task :shell do
  sh 'docker run -ti skatzer/mrubycross:kinetic /bin/bash -l'
end

desc 'Push image'
task :push do
  sh 'docker push skatzer/mrubycross:kinetic'
end

desc 'Pull image'
task :push do
  sh 'docker pull skatzer/mrubycross:kinetic'
end
