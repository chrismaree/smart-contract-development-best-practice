contract simpleParityHack {

function initMultiowned ( address [] _owners ,uint _required ) {
    if ( m_numOwners > 0) throw ;
    m_numOwners = _owners.length + 1;
    m_owners [1] = uint (msg.sender ) ;
    m_ownerIndex [uint ( msg.sender )] = 1;
    m_required = _required ;
    /* ... */
}

function kill ( address _to ) {
    uint ownerIndex = m_ownerIndex [ uint ( msg.sender)];
    if ( ownerIndex == 0) return ;
    var pending = m_pending [ sha3 ( msg.data ) ];
    if ( pending.yetNeeded == 0) {
        pending.yetNeeded = m_required ;
        pending.ownersDone = 0;
    }
    uint ownerIndexBit = 2** ownerIndex ;
    if ( pending.ownersDone & ownerIndexBit == 0) {
        if ( pending.yetNeeded <= 1)
            suicide (_to) ;
            else {
            pending.yetNeeded --;
            pending.ownersDone |= ownerIndexBit ;
        }
    }
}
}
