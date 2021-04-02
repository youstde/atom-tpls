import { useEffect } from 'react';
import { PaginatedParams } from 'ahooks/lib/useAntdTable';
import { useAntdTable } from 'ahooks';
import { basicCommonApi } from '@/apis';

const default_page_size = 20;

const useData = (form) => {
  const fetchListData = (
    { current, pageSize }: PaginatedParams[0],
    formData
  ) => {
    console.log(formData);
    return basicCommonApi.fetchDemoListData({
      currentPage: current,
      currentSize:pageSize,
      ...formData
    }).then((res:any) => ({
      total: res.totalSize,
      list: res.list
    }));
  }

  const { tableProps, search, refresh } = useAntdTable(fetchListData, {
    defaultPageSize: default_page_size,
    form,
    manual: true,
  });

  const { submit } = search;

  useEffect(() => {
    submit();
  }, []);

  return {
    tableProps,
    search,
    refresh
  }
}

export default useData;