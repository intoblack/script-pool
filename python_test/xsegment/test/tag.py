# coding=utf-8
#!/usr/bin/env python

from collections import defaultdict
import sys
import os
import json
import re
reload(sys)
sys.setdefaultencoding('utf-8')


class HSpeech(object):
    __start_state = None
    __emission_probability = None
    __transition_probability = None
    __states = None
    __min_value = 0.000000000001

    def __init__(self, model=os.path.join(os.path.abspath(os.path.dirname(__file__)),  '')):
        self.__load(model)

    def __load(self, path):
        if path:
            if not path.endswith('/'):
                path = path + '/'
            with open('%s%s' % (path, 'tag_start_state.dat')) as f:
                self.__start_state = json.loads(f.readline())
            with open('%s%s' % (path, 'tag_emission_probability.dat')) as f:
                self.__emission_probability = json.loads(f.readline())
            with open('%s%s' % (path, 'tag_transition_probability.dat')) as f:
                self.__transition_probability = json.loads(f.readline())
            with open('%s%s' % (path, 'tag_obs_status.dat')) as f:
                j = json.loads(f.readline())
                self.__states = [__key for __key in j.keys()]

    def __viterbi(self, obs):
        '''
        �ر��㷨 ժ��wiki ά�ر��㷨
        '''
        # print obs
        V = [{}]
        path = {}
        for y in self.__states:
            if self.__emission_probability[y].has_key(obs[0]):
                V[0][y] = self.__start_state[y] * \
                    self.__emission_probability[y][obs[0]]
            else:
                V[0][y] = self.__start_state[y] * self.__min_value
            path[y] = [y]
        for t in range(1, len(obs)):
            V.append({})
            newpath = {}
            for y in self.__states:
                prob = 0.
                state = self.__states[0]
                for y0 in self.__states:
                    if self.__emission_probability[y].has_key(obs[t]):
                        __prob = V[
                            t - 1][y0] * self.__transition_probability[y0][y] * self.__emission_probability[y][obs[t]]
                    else:
                        __prob = V[
                            t - 1][y0] * self.__transition_probability[y0][y] * self.__min_value
                    if __prob > prob:
                        prob = __prob
                        state = y0
                V[t][y] = prob
                newpath[y] = path[state] + [y]
            path = newpath
        (prob, state) = max([(V[len(obs) - 1][y], y) for y in self.__states])
        return (prob, path[state])

    def tag(self, segment_words, split_word=' '):
        '''
        ���ܣ�
               ���Ա�ע 
        ������
               segment_words �� �ִʽ�� 
               �������Ϊ�ַ��� �� �����Կո����tab��Ϊ�ָ������ַ���
               ������Ͳ�Ϊlist �� tuple �� ���׳��쳣 
        �㷨��
               hmm ά�ر��㷨
        return �������Ϊ�ջ���None �򷵻ؿյ�list
               ���򣬷���[(�ִ�1������),(�ִ�2������)....(�ִ�n������n)]
        '''
        if segment_words:
            if isinstance(segment_words, str):
                segment_words = segment_words.decode('utf-8').split(split_word)
            elif isinstance(segment_words, unicode):
                segment_words = segment_words.split(split_word)
            elif not isinstance(segment_words, (list, tuple)):
                raise Exception, 'type erro!'
            state = self.__viterbi(segment_words)[1]
            return [(segment_words[i], state[i]) for i in range(len(segment_words))]
        return []  # �������none �� ����ɲ���Ҫ���жϺʹ���


class TrainTag(object):
    __start_state = defaultdict(float)
    __hide_state = defaultdict(float)
    tag_find = re.compile('/[a-z]+').finditer
    # Ϊ�˷�ֹ�� 0 �� �����쳣 �� ��ÿ��״̬��ʼ��Ϊ1��
    # ��ʼ״̬���󹹽�
    # ����״̬ת��
    __transition_probability = {}
    # ����״̬�¸����۲�״̬����Ƶ��
    __emission_probability = {}

    word_state = set() #��

    def save_state(self):
        with open('tag_start_state.dat', 'w') as f:
            f.write(json.dumps(self.__start_state))
        with open('tag_emission_probability.dat', 'w') as f:
            f.write(json.dumps(self.__emission_probability))
        with open('tag_transition_probability.dat', 'w') as f:
            f.write(json.dumps(self.__transition_probability))
        with open('tag_obs_status.dat', 'w') as f:
            f.write(json.dumps(self.__hide_state))

    def add_line(self, line, file_name=None):
        try:
            tags = [(label[0], label[1].strip()) for label in
                    [__tag.split('/') for __tag in line.strip().split()]
                    if len(label) > 1 and label[1] != '' and label[0] != ""]
            if not len(tags):return
            self.__start_state[tags[0][1]] += 1.
            for i in range(0, len(tags) - 1):
                if not self.__transition_probability.has_key(tags[i][1]):
                    self.__transition_probability[
                        tags[i][1]] = defaultdict(float)
                self.__transition_probability[
                    tags[i][1]][tags[i + 1][1]] += 1
            for __tag in tags:
                self.word_state.add(__tag[0])
                self.__hide_state[__tag[1]] += 1
                if not self.__emission_probability.has_key(__tag[1]):
                    self.__emission_probability[__tag[1]] = defaultdict(float)
                self.__emission_probability[__tag[1]][__tag[0]] += 1
        except Exception, e:
            print e, line, file_name

    def train(self, file_name):
        with open(file_name) as f:
            for line in f.readlines():
                self.add_line(line)
        self.translte()

    def translte(self):
        '''
        ��״̬����ת��Ϊ����
        '''
        # ��ʼ��������Ŀ
        print 'train'
        print self.__hide_state
        sum_start_count = 0
        for __key in self.__hide_state.keys():
            self.__start_state[__key] += 0.
        sum_start_count = sum (self.__start_state.values())
        # ���㿪ʼ״̬���� , ����ÿ����ʼ��ǩ���ֵĸ���
        for tag in self.__start_state.keys():
            self.__start_state[tag] = self.__start_state[
                tag] / sum_start_count
        # ��ʼ����������������

        # ת�ƾ���
        for __state in self.__transition_probability.keys():
            for __afther_state in self.__hide_state.keys():
                # ���㹫ʽ =�� p(Cj | Ci) = count(Ci,Cj) / count(Ci)
                self.__transition_probability[__state][__afther_state] = (self.__transition_probability[
                    __state][__afther_state] + 0.0000001) / (self.__hide_state[__state] + 0.000001)

         # �۲�״̬����ʱ�� ����״̬��������
        for __hide in self.__emission_probability.keys():
           for word in self.__emission_probability[__hide].keys():
                try:
                    self.__emission_probability[__hide][word] = (
                    self.__emission_probability[__hide][word] + 1) / (self.__hide_state[__hide] + 1)
                except Exception,e:
                    print __hide

if __name__ == '__main__':
    h = HSpeech()
    # # print h.viterbi( [u'��' , u'�� ' , u'��' ])
    # # print h.viterbi( [u'��ϲ' , u'��' , u'����'])
    print h.tag('�� �� ��� !'.decode('utf-8'))
    print h.tag('xsegment')
    # t = TrainTag()
    # t.add_line(
    # u'Խ��/ns ����̨/n ����/v ��/u ���/a ����/n ��Ϊ/c ����/v ��/c >���/v ��/u ����/a ��Ǯ/n ��/u
    # ��Ϣ/n ��/w ����/v ���ӻ�/n ��/u �ư�/n ��/p ֱ��/v ����/v ʱ/nt ��/v ��/u ˮй��ͨ/i ��/w')

    # word = re.compile('/[a-z]+\s?')
    # diff = set()
    # for file_name in os.listdir("d:/data/chinese/"):
    #     file_path = '%s%s' % ('d:/data/chinese/', file_name)
    #     with open(file_path) as f:
    #         content = f.readlines()
    #         wd = content[2].decode('utf-8').strip()[-1]
    #         for line in content[6:]:
    #             line = line.decode('utf-8')
    #             if line in diff:
    #                 continue
    #             diff.add(line)
    #             line = line.strip().replace(
    #                 ' [%s]' % wd, wd).split("\t")[2].decode('utf-8')
    #             t.add_line(line, file_path)
    # t.translte()
    # t.save_state()
