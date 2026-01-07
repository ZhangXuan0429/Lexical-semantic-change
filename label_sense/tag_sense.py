import pickle as p
from utils import lemmatize,cosSimilarity,convert_pos

# load dict data
dict_data = './dict/poly_words.pickle'
sense_emb = './dict/sense_embeddings.pickle'

with open(dict_data, 'rb') as f:
    target_words = p.load(f)

with open(sense_emb,'rb') as f:
    dic = p.load(f)

print('loaded {} polysemous words and {} sense embeddings.'.format(len(target_words), len(dic)))

def tagSenseFromWordDict(word, word_emb): 
    '''
    when setting withPOS as True, retrieve the candidate senses of the same pos tag.
    '''
    # retrieve the candidate sense keys
    candidates = target_words[word]

    # compute the similarities and sort
    simi = {}
    for sid in candidates:
        if sid in dic:
            sense_emb = dic[sid]
            similarity = cosSimilarity(word_emb, sense_emb)
            simi[sid] = similarity

    if simi:
        sort_simi = sorted(simi.items(), key=lambda d:d[1], reverse=True)
        return sort_simi[0]
    else:
        return []
